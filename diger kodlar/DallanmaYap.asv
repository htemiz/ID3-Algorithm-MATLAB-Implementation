
function [Agac niteliklerVektoru aktifKayitVektoru] = DallanmaYap( niteliklerSutunu, VeriSeti, NiteliklerVektoru, AktifKayitVektoru, SiniflarVektoru)

Agac = struct;
niteliklerVektoru = 1;
aktifKayitVektoru = 1;

nitelikleradedi = length(niteliklerSutunu.AltNitelikler);

%her seferinde bir yaprak çýkýyor mu bakalým
for h = 1: nitelikleradedi    
        if length (niteliklerSutunu.AltNitelikler(h).Siniflar) == 1 % sadece tek bir sýnýf var. yani yaprak.
            Agac(h).Sinif = niteliklerSutunu.AltNitelikler(h).Siniflar;
            Agac(h).NitelikAdi = niteliklerSutunu.AltNitelikler(h).NitelikAdi;
            Agac(h).AltAgac = struct; 
            
            % bu sýnýf için kayýt satýrlarýnýn tekrar iþlenmemesi için
            % kapatýlmasý gerekiyor. "1" deðerine atanmalarý kapatýlmalarý
            % anlamýna geliyor.
            AktifKayitVektoru(niteliklerSutunu.AltNitelikler(h).Siniflar.Kayitlar) = 1; 
        else
            Agac(h).AltAgac = ID3(VeriSeti, SiniflarVektoru, NiteliklerVektoru, AktifKayitVektoru);
            
        end
        
end
a=5;
end
