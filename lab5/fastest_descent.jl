using ForwardDiff, LinearAlgebra
include("../lab2/golden_section.jl")

function fast_min(f, x0, a, b, epsilon, gs_epsilon, n)
    d = 0
    lambda = 0
    gradient = ForwardDiff.gradient(f, x0)

    while norm(gradient) > epsilon && n > 0
        gradient = ForwardDiff.gradient(f, x0)
        d = -gradient
        g(x) = f(x0 + x * d)
        lambda = golden_section(g, a, b, gs_epsilon)
        x0 = x0 + lambda * d
        n = n - 1
    end

    return x0, d, lambda
end

epsilon = 0.1
gs_epsilon = 0.01
a = -10
b = 10
x0 = [2, 2]
max_iter = 1000
f(x) = (x[1] - 3)^4 + (x[1] - 3 * x[2])^2
xmin, d, lambda = fast_min(f, x0, a, b, epsilon, gs_epsilon, max_iter) 

println("xmin: ", xmin)
println("ymin: ", f(xmin))
println("last direction of descent: ", d)
println("last step size: ", lambda)