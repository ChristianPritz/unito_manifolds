function plot_pcs(latent,sttngs)
figure();
time = [1:size(latent,2)]/sttngs.frameRate;
subplot(3,1,1),plot(time,latent(1,:));
ylabel('PC1');
subplot(3,1,2),plot(time,latent(2,:));
ylabel('PC2');
subplot(3,1,3),plot(time,latent(3,:));
ylabel('PC3');
xlabel('Time (s)');


figure(),subplot(2,2,1),plot(latent(1,:),latent(2,:))
xlabel('PC2'),ylabel('PC1');
subplot(2,2,2),plot(latent(1,:),latent(3,:))
xlabel('PC3'),ylabel('PC1');
subplot(2,2,3),plot(latent(2,:),latent(3,:))
xlabel('PC2'),ylabel('PC3');
subplot(2,2,4),plot3(latent(1,:),latent(2,:),latent(3,:))
xlabel('PC2'),ylabel('PC1'),zlabel('PC3');
axis equal;

end