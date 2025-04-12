function [phi21ext, e21ext, gci21, e21abs, p] = gci(phi, r21, r32, fs)
% AUTHOR - Carter Gassler
% phi is a 3xn matrix where n is the number of sets of 3 values to do a GCI on
% there can be n different variables, the same variables in n different conditions,
% or a combination thereof.
% 1 - fine, 2 - med, 3 - coarse
% r21 = h2/h1 = (N1/N2)^(1/3) (3D case)
if size(phi,1) ~= 3
    error("height of phi must be 3")
end
if nargin == 3
    fs = 1.25;
end

eps21 = phi(2,:) - phi(1,:);
eps32 = phi(3,:) - phi(2,:);
n = size(phi,2);
p = zeros(1,n);
for idx = 1:n
    if eps21(idx) == 0
        p(idx) = 10; % set this to a large number if we've reached the "true" solution on med. mesh
        continue
    end
    if abs(r21 - r32) < 1e-10
        p(idx) = 1/log(r21)*abs(log(abs(eps32(idx)/eps21(idx))));
    else
        s = sign(eps32(idx)/eps21(idx));
        q = @(p) log((r21^p - s)/(r32^p - s));
        f = @(p) p - 1/log(r21)*abs(log(abs(eps32(idx)/eps21(idx))) + q(p));

        p(idx) = fzero(f,1);
    end
end

phi21ext = (r21.^p.*phi(1,:) - phi(2,:))./(r21.^p - 1);

e21a = abs((phi(1,:) - phi(2,:))./phi(1,:));
e21ext = abs((phi21ext - phi(1,:))./phi21ext);

gci21 = fs*e21a./(r21.^p - 1);
e21abs = phi(1,:).*gci21;

end
