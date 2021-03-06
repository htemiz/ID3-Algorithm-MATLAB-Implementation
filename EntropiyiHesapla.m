% Nitelik s?tunundaki s?n?flar?n entropisini hesaplar
function [Entropi ToplamAdet] = EntropiyiHesapla(siniflar)

ToplamAdet  =0;

Entropi = 0;

sinifsayisi =  length(siniflar);

    for h = 1: sinifsayisi
      ToplamAdet = siniflar(h).adet + ToplamAdet;
    end
    
    for h = 1: sinifsayisi      
        Adet = siniflar(h).adet ;
        
       Entropi = Entropi  - (Adet / ToplamAdet) * log2(Adet / (ToplamAdet + eps));
    end
end

