function trapecio_dinamico()
    clc; close all;
    
    % Función a integrar
    f = @(x) 0.2 + 25*x - 200*x.^2 + 675*x.^3 - 900*x.^4 + 400*x.^5;
    
    % Segunda derivada (estimación de error)
    f2 = @(x) -400 + 6*675*x - 12*900*x.^2 + 20*400*x.^3;

    % Límites
    a = 0;
    b = 0.8;

    % Valor exacto conocido
    exacto = 1.640533;

    % ----------------- Cálculo manual con n = 10 -----------------
    fprintf('\n---- Cálculo manual con n = 10 ----\n');
    [I10, h10] = trapecio_compuesto(f, a, b, 10);
    error_abs10 = abs(exacto - I10);
    error_porcentual10 = (error_abs10 / exacto) * 100;
    error_estimado10 = ((b-a)*h10^2)/12 * max(abs(f2(a:0.01:b)));

    fprintf('Aproximación con n=10: %.6f\n', I10);
    fprintf('Error absoluto: %.6f\n', error_abs10);
    fprintf('Error porcentual: %.4f%%\n', error_porcentual10);
    fprintf('Error estimado (segunda derivada): %.6f\n', error_estimado10);

    % ----------------- Ciclo para cálculos dinámicos -----------------
    while true
        n = input('\nIngrese un valor de n (0 para salir): ');
        if n <= 0
            fprintf('Fin del programa.\n');
            break;
        end

        fprintf('\n---- Cálculo con n = %d ----\n', n);
        [I_n, h_n] = trapecio_compuesto(f, a, b, n);
        error_abs_n = abs(exacto - I_n);
        error_porcentual_n = (error_abs_n / exacto) * 100;
        error_estimado_n = ((b-a)*h_n^2)/12 * max(abs(f2(a:0.01:b)));

        fprintf('Aproximación con n=%d: %.6f\n', n, I_n);
        fprintf('Error absoluto: %.6f\n', error_abs_n);
        fprintf('Error porcentual: %.4f%%\n', error_porcentual_n);
        fprintf('Error estimado (segunda derivada): %.6f\n', error_estimado_n);
    end
end

function [I, h] = trapecio_compuesto(f, a, b, n)
    h = (b - a)/n;
    x = a:h:b;
    y = f(x);
    I = (h/2) * (y(1) + 2*sum(y(2:end-1)) + y(end));
end
