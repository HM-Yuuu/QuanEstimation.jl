"""
    Adam()

"""
function Adam(gt, t, para, m_t, v_t, alpha=0.01, beta1=0.90, beta2=0.99, epsilon=1e-8)
    t = t+1
    m_t = beta1*m_t + (1-beta1)*gt
    v_t = beta2*v_t + (1-beta2)*(gt*gt)
    m_cap = m_t/(1-(beta1^t))
    v_cap = v_t/(1-(beta2^t))
    para = para+(alpha*m_cap)/(sqrt(v_cap)+epsilon)
    return para, m_t, v_t
end
function Adam!(grape, δ, mt=0.0, vt=0.0)
    for ctrl in 1:length(δ)
        for ti in 1:length(grape.times)
            grape.control_coefficients[ctrl][ti], mt, vt = Adam(δ[ctrl][ti], ti, grape.control_coefficients[ctrl][ti], mt, vt)
        end
    end
end