p = 100*[-2 -1 0 1 2; 10 2 1 2 10];
ptest = 100*[0;3];

    hold all;
    for i=1:1000
        noise = [randn(length(p),1)';randn(length(p),1)'];
        pcorrupt = p + noise;

        H = computeH(p,pcorrupt);
        Hn = computeH_norm(p,pcorrupt);

        p_nn = H*[ptest;1];
        p_norm = Hn*[ptest;1];
        %p_norm = eye(3)*[ptest;1]
        plot(p_norm(1)/p_norm(3),p_norm(2)/p_norm(3),'.b');
        plot(p_nn(1)/p_nn(3),p_nn(2)/p_nn(3),'.r');

        %plot(p_norm(1),p_norm(2),'.b');
        %plot(p_nn(1),p_nn(2),'.r');

        pnn(:,i) = p_nn;
        pnorm(:,i) = p_norm;

    end
    %might need to scale --- nevermind, I scaled it. 
    axis equal;
    legend('Normalized','Unnormalized');
    covariance1 = cov(pnn(1,:)./pnn(3,:),pnn(2,:)./pnn(3,:))
    covariance2 = cov(pnorm(1,:)./pnorm(3,:),pnorm(2,:)./pnorm(3,:))
    [s,c] = cov2corr(covariance1)
    max(eig(covariance1))
    [s,c] = cov2corr(covariance2)
    ratio = sqrt(max(eig(covariance1))) / sqrt(max(eig(covariance2)))
    
    hold off;
    %close all;

