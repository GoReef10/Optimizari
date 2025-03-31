function golden_section(f, a, b, epsilon)
    alpha = (sqrt(5) - 1) / 2
    while abs(b - a) > epsilon
        lambda = a + (1 - alpha) * (b - a)
        mu = a + alpha * (b - a)
        if f(lambda) >= f(mu)
            a = lambda
            lambda = mu
            mu = a + alpha * (b - a)
        else
            b = mu
            mu = lambda
            lambda = a + (1 - alpha) * (b - a)
        end
    end
    return (a + b) / 2
end

f(t) = t^2 + t + 1
xmin = golden_section(f, -3, 3, 0,01)
println(xmin)
println(f(xmin))