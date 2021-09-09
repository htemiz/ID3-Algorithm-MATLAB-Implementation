
%
% Nitelik s�tunundaki her bir farkl� de�eri buluyor.
% sonras�nda her bir alt de�er i�in entropi ve di�er 
% hesaplamalar yap�l�yor.
%
function AltNitelikler = NiteliginAltNitelikler(NitelikSutunu, SiniflarVektoru, AktifKayitVektoru)
   
NitelikDegerleri = AltNiteliklerDizisiOlustur(NitelikSutunu, AktifKayitVektoru);

% s�tunda ka� adet nitelik oldu�unu bulduk. 
% her bir nitelik de�eri i�in ka�tane s�n�f oldu�unu ve entropiyi bulal�m
%
yerelAktifKayitVektoru = AktifKayitVektoru;     % vekt�r� yeniden atayal�m.

AltNitelikler = struct;

% her bir nitelik de�eri tek tek incelenecek
% her biri i�in ka� s�n�f etiketi oldu�u bulunacak
% s�n�flar yap�lar� olu�turulacakA
for i = 1 : length (NitelikDegerleri)
    % her bir sat�r i�in. yani her bir kay�t i�in bu i�lemi yap
    
    siniflar = struct;
    ilksinif  =true ; % ilk defa s�n�f �retiliyor. bu durum sadece ilk
    % kez bir nitelik i�in s�n�flar buAlunmaya %�al���l�rken ger�ekle�iyor
    
    for j= 1: length(yerelAktifKayitVektoru)
        % sat�r i�lenmeye kapat�lmam��sa hesaba dahil et!
        if((yerelAktifKayitVektoru(j) == 0) && (NitelikDegerleri(i) == NitelikSutunu(j)))            
            if(ilksinif)
                siniflar = struct('adi',SiniflarVektoru(j), 'adet', 1, 'Kayitlar',j);
                ilksinif = false;
            else
                sinifYeniBirSiniftir = true;                
                for m = 1: length(siniflar)
                    if (siniflar(m).adi == SiniflarVektoru(j))
                        siniflar(m).adet = siniflar(m).adet + 1;
                        siniflar(m).Kayitlar = [siniflar(m).Kayitlar j]; % hangi sat�rlar�n (kay�tlar�n) bu s�n�f i�in oldu�u bilgisi
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
            end        % yeni s�n�f ekleme bitti
            yerelAktifKayitVektoru(j) = 1;
        end % her yap� i�in s�n�f� ekleme bitti        
    end
    %Entropi ve Toplam kay�t say�s�n� hesapla.
    [Entropi ToplamAdet] = EntropiyiHesapla(siniflar);
    
    % bu alt nitelik i�in inceleme tamamland�. s�n�flar bulundu.
    if (i == 1) % daha evvel alt nitelik eklenmedi demektir. ilk defa olu�turulacak
        AltNitelikler.AltNitelikAdi = NitelikDegerleri(1);
        AltNitelikler.Entropi = Entropi; % Alt niteli�in entropisi
        AltNitelikler.ToplamAdet = ToplamAdet; % Toplam Kay�t say�s�
        AltNitelikler.Siniflar = siniflar;        
    else
        AltNitelikler(i).AltNitelikAdi = NitelikDegerleri(i);
        AltNitelikler(i).Entropi = Entropi; % Alt niteli�in entropisi
        AltNitelikler(i).ToplamAdet = ToplamAdet; % Toplam Kay�t say�s�
        AltNitelikler(i).Siniflar = siniflar;
    end
    
end  % s�n�flar�n incelenmesi tamamland�.

%toplam(AltDegerler);
end





 