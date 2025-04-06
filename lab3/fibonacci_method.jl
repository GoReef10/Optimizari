function get_fibonacci_sequence(a, b, epsilon)
    fib = [1, 1]
    limit = (b - a) / epsilon
    while true
        next_fib = fib[end] + fib[end-1]
        push!(fib, next_fib)
        if next_fib > limit
            break
        end
    end
    return fib
end

function fibonacci_method(f, a, b, epsilon)
    fib = get_fibonacci_sequence(a, b , epsilon)
    n = length(fib)
    lambda = a + fib[n - 2] / fib[n] * (b - a)
    mu     = a + fib[n - 1] / fib[n] * (b - a)
    for k = 1 : n - 2
        if f(lambda) >= f(mu)
            a = lambda
            b = b
            lambda = mu
            mu = a + fib[n - k - 1] / fib[n - k]  * (b - a)
        else
            a = a
            b = mu
            mu = lambda
            lambda = a + fib[n - k - 2] / fib[n - k]  * (b - a)
        end
    end
    mu = lambda + epsilon
    if f(lambda) > f(mu)
        a = lambda
    else
        b = lambda
    end
    return (a + b) / 2
end

f(x) = x^2 - x * cos(x)
a = -3
b = 4
epsilon = 0.01
println(get_fibonacci_sequence(a, b, epsilon))
min = fibonacci_method(f, a, b, epsilon)
println(min)
println(f(min))