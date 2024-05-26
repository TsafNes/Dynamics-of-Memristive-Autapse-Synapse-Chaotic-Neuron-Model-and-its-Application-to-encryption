function psnr = PSNR(inputimg1, inputimg2)
    [row, col] = size(inputimg1);
    psnr = 10*log10(255^2*row*col/sum(sum((uint8(inputimg1)-uint8(inputimg2)).^2)));
end

