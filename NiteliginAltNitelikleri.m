
%
% Nitelik sütunundaki her bir farklý deðeri buluyor.
% sonrasýnda her bir alt deðer için entropi ve diðer 
% hesaplamalar yapýlýyor.
%
function AltNitelikler = NiteliginAltNitelikler(NitelikSutunu, SiniflarVektoru, AktifKayitVektoru)
   
NitelikDegerleri = AltNiteliklerDizisiOlustur(NitelikSutunu, AktifKayitVektoru);

% sütunda kaç adet nitelik olduðunu bulduk. 
% her bir nitelik deðeri için kaçtane sýnýf olduðunu ve entropiyi bulalým
%
yerelAktifKayitVektoru = AktifKayitVektoru;     % vektörü yeniden atayalým.

AltNitelikler = struct;

% her bir nitelik deðeri tek tek incelenecek
% her biri için kaç sýnýf etiketi olduðu bulunacak
% sýnýflar yapýlarý oluþturulacakA
for i = 1 : length (NitelikDegerleri)
    % her bir satýr için. yani her bir kayýt için bu iþlemi yap
    
    siniflar = struct;
    ilksinif  =true ; % ilk defa sýnýf üretiliyor. bu durum sadece ilk
    % kez bir nitelik için sýnýflar buAlunmaya %çalýþýlýrken gerçekleþiyor
    
    for j= 1: length(yerelAktifKayitVektoru)
        % satýr iþlenmeye kapatýlmamýþsa hesaba dahil et!
        if((yerelAktifKayitVektoru(j) == 0) && (NitelikDegerleri(i) == NitelikSutunu(j)))            
            if(ilksinif)
                siniflar = struct('adi',SiniflarVektoru(j), 'adet', 1, 'Kayitlar',j);
                ilksinif = false;
            else
                sinifYeniBirSiniftir = true;                
                for m = 1: length(siniflar)
                    if (siniflar(m).adi == SiniflarVektoru(j))
                        siniflar(m).adet = siniflar(m).adet + 1;
                        siniflar(m).Kayitlar = [siniflar(m).Kayitlar j]; % hangi satýrlarýn (kayýtlarýn) bu sýnýf için olduðu bilgisi
                        sinifYeniBirSiniftir = false;                        
                        break;
                    end
                end
                if(sinifYeniBirSiniftir)
                    indeks = length(siniflar);
                    ad = SiniflarVektoru(j);
                    siniflar(indeks + 1).adi = ad;
                    siniflar(indeks + 1).adet = 1;
                    siniflar(indeks + 1).Kayitlar = j;
                end
            end        % yeni sýnýf ekleme bitti
            yerelAktifKayitVektoru(j) = 1;
        end % her yapý için sýnýfý ekleme bitti        
    end
    %Entropi ve Toplam kayýt sayýsýný hesapla.
    [Entropi ToplamAdet] = EntropiyiHesapla(siniflar);
    
    % bu alt nitelik için inceleme tamamlandý. sýnýflar bulundu.
    if (i == 1) % daha evvel alt nitelik eklenmedi demektir. ilk defa oluþturulacak
        AltNitelikler.AltNitelikAdi = NitelikDegerleri(1);
        AltNitelikler.Entropi = Entropi; % Alt niteliðin entropisi
        AltNitelikler.ToplamAdet = ToplamAdet; % Toplam Kayýt sayýsý
        AltNitelikler.Siniflar = siniflar;        
    else
        AltNitelikler(i).AltNitelikAdi = NitelikDegerleri(i);
        AltNitelikler(i).Entropi = Entropi; % Alt niteliðin entropisi
        AltNitelikler(i).ToplamAdet = ToplamAdet; % Toplam Kayýt sayýsý
        AltNitelikler(i).Siniflar = siniflar;
    end
    
end  % sýnýflarýn incelenmesi tamamlandý.

%toplam(AltDegerler);
end





 