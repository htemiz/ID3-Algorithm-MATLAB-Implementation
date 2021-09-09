%% örnek kullaným
%% [Agac NitelikVektoru] = ID3(ikibinlik_etiketsiz, ikibinlik_sayi_etiketli(:,end), zeros(1,34), zeros(2000,1))
%% [Agac NitelikVektoru] = ID3(ikibinlik_etiketsiz, ikibinlik_sayi_etiketli(:,end), zeros(1,34), zeros(2000,1))
%% [Agac NitelikVektoru] = ID3(besyuzluk_etiketsiz, ikibinlik_sayi_etiketli(:,end), zeros(1,34), zeros(500,1))
%% [Agac NitelikVektoru] = ID3(besyuzluk_etiketsiz,besyuzluk_sinifvektoru_ikilik, zeros(1,34), zeros(500,1));

function [Agac NiteliklerVektoru] = ID3(VeriSeti, SiniflarVektoru, NiteliklerVektoru, AktifKayitVektoru)
Agac = struct;
%%
% NiteliklerVektoru deðiþkeni nitelik sütunlarýnýn aktif olup olmadýðýna
% dair bilgiyi tutar.
% 0' deðeri nitelik sütunun aktif ve iþleme sokulmasý gerektiðini ifade eder.
%
% 1' deðeri sütunun artýk iþleme alýnmamasý gerektiðini ifade eder.

% kaç adet nitelik sütunu mevcut ve kaç adet kayýt mevcut
[KayitSayisi NitelikSayisi] = size(VeriSeti);

if (sum(AktifKayitVektoru) == KayitSayisi)
    % Aktif kayýt kalmamýþ, yani tüm satýrlar iþlenmiþ; devam etmeye gerek kalmadý.    
    return ;
end

%Nitelik sütununda sadece bir deðer varsa, hesaplamaya katmaya gerek yoktur.
NiteliklerVektoru = TekDegerliNitelikleriEtkisizYap(VeriSeti, NiteliklerVektoru, AktifKayitVektoru);

% her bir aktif nitelik sütunu için, nitelik sütunu ve alt niteliklerine
% ait bilgiler bir yapý elemanýnda saklanmak üzere hesaplanýyor...
for i = 1: NitelikSayisi
    NitelikSutunlari(i).Adi= i;    
    if(NiteliklerVektoru(i) == 0) % nitelik sütunu aktif iþleme al!
        NitelikSutunlari(i).AltNitelikler = ...  % alt nitelikleri bul
                NiteliginAltNitelikleri(VeriSeti(:,i), SiniflarVektoru, AktifKayitVektoru);
        NitelikSutunlari(i).NitelikEntropisi = ... % nitelik sütununun  entropisini bul
                NitelikEntropisiniHesapla( NitelikSutunlari(i).AltNitelikler);
    end
end

OncekiDegerYok = true; % niteliklerin entropilerini karþýlaþtýrmada önceki veriyi saklar
NiteliklerTamamlandi = true;

% hangi sütuna göre dallanma yapýlacaðýný bulalým
for i = 1: NitelikSayisi    
    if(NiteliklerVektoru(i) == 0) % nitelik sütunu aktif iþleme al
        if (OncekiDegerYok)
            dallanmaindeksi= i;
            oncekideger = NitelikSutunlari(1).NitelikEntropisi;
            OncekiDegerYok = false;
            NiteliklerTamamlandi = false;
        else            
            simdikideger = NitelikSutunlari(i).NitelikEntropisi;
            if( simdikideger > oncekideger)
                dallanmaindeksi = i;
                oncekideger = simdikideger;
            end
            NiteliklerTamamlandi = false;
        end
    end
end

% nitelikler tamamlanmýþ, yani hepsi 1 yapýldýðýnda program artýk devam
% etmemeli. tüm nitelik sütunlarý iþlenmiþ demektir. dolayýsýyla bir
% üstteki döngüde hiçbir nitelik sütunu iþlenemeiþtir. iþlem bitmiþtir.
if(NiteliklerTamamlandi)
    return;
end

% dallanýlacak sütunu bulduk.
DallanilanNitelikSutunu = NitelikSutunlari(dallanmaindeksi);
nitelikleradedi = length(DallanilanNitelikSutunu.AltNitelikler); % bu sütunda kaç tane alt nitelik var.
AltAgacIndeksi = 1; % alt aðaç oluþturmak için ilk indeks

%her seferinde bir yaprak çýkýyormu bakalým
for h = 1: nitelikleradedi    
        if length (DallanilanNitelikSutunu.AltNitelikler(h).Siniflar) == 1 % sadece tek bir sýnýf var. yani yaprak.
            altAgac(AltAgacIndeksi).Sinif = DallanilanNitelikSutunu.AltNitelikler(h).Siniflar;
            altAgac(AltAgacIndeksi).NitelikAdi = DallanilanNitelikSutunu.AltNitelikler(h).AltNitelikAdi;
            altAgac(AltAgacIndeksi).AltAgac = struct;             
            % bu sýnýf için kayýt satýrlarýnýn tekrar iþlenmemesi için
            % kapatýlmasý gerekiyor. "1" deðerine atanmalarý kapatýlmalarý
            % anlamýna geliyor.
            AktifKayitVektoru(DallanilanNitelikSutunu.AltNitelikler(h).Siniflar.Kayitlar) = 1; 
            AltAgacIndeksi = AltAgacIndeksi + 1;
        end
end

% tüm alt nitelikler yaprak ile sonuçlanabilir. 
% dolayýsýyla yukarýdaki koddan sonra tüm AktifKayýtlar iþlenmeye
% kapatýlabilir. bu durumda iþlenecek kayýt kalmaz ve sýnýflandýrma
% tamamlanmýþ olur. dolayýsýyla programýn iþi bitmiþtir.
AktifKayitVektoruToplami  =sum(AktifKayitVektoru);
if (AktifKayitVektoruToplami == KayitSayisi)
    % Aktif kayýt kalmamýþ devam etmeye gerek kalmadý.    
    return ;
end

% yaprak olmayan alt nitelikler için dallanma yap
for h = 1: nitelikleradedi
    if length (DallanilanNitelikSutunu.AltNitelikler(h).Siniflar) > 1 % birden fazla sýnýf var ise dallan
        vektor = ones(length(AktifKayitVektoru),1);        
        kayitlar = [];        
        for k = 1: length(DallanilanNitelikSutunu.AltNitelikler(h).Siniflar)
            kayitlar = [kayitlar DallanilanNitelikSutunu.AltNitelikler(h).Siniflar(k).Kayitlar];            
        end        
        % yeni iþlenen ve sýnýfý belli olan kayitlarý ve 
        % bu zamana dek iþlenmiþ olan kayitlari iþlemeye kapatalým        
        vektor(kayitlar) = 0;
        vektor(find (AktifKayitVektoru == 1)) = 1;
        
        [agac nitelikler] = ID3(VeriSeti, SiniflarVektoru, NiteliklerVektoru, vektor);
        
        altAgac(AltAgacIndeksi).Sinif = DallanilanNitelikSutunu.AltNitelikler(h).Siniflar;
        altAgac(AltAgacIndeksi).NitelikAdi = DallanilanNitelikSutunu.AltNitelikler(h).AltNitelikAdi;
        
        if ~isempty(fields(agac))
            altAgac(AltAgacIndeksi).AltAgac = agac;
        else
            altAgac(AltAgacIndeksi).AltAgac = struct;
        end
        
        AltAgacIndeksi = AltAgacIndeksi + 1;
        NiteliklerVektoru = nitelikler;
    end
end

%
%[agac niteliklerVektoru aktifKayitVektoru] = DallanmaYap( NitelikSutunlari(dallanmaindeksi), VeriSeti, NiteliklerVektoru, AktifKayitVektoru, SiniflarVektoru)
Agac.AltAgac = altAgac;
Agac.AgacinAdi = dallanmaindeksi;

end






