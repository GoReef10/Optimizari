using ForwardDiff
using LinearAlgebra

function newton_method(f, x0, epsilon, max_iter)
    k = 1
    while norm(ForwardDiff.gradient(f, x0)) > epsilon && k <= max_iter
        hess = ForwardDiff.hessian(f, x0)
        if isposdef(hess) != true
            hess = hess * hess'
        end
        x0 = x0 - hess \ ForwardDiff.gradient(f, x0)
        k += 1
    end
    return x0, f(x0)
end


f(t) = (t[1] - 3)^4 + (t[1] - 3*t[2])^2
x0 = [10, 10]
epsilon = 0.01
maxiter = 1000
xmin, ymin = newton_method(f, x0, epsilon, maxiter)
println("Minimum point: ", xmin)
println("Minimum value: ", ymin)