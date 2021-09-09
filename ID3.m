%% �rnek kullan�m
%% [Agac NitelikVektoru] = ID3(ikibinlik_etiketsiz, ikibinlik_sayi_etiketli(:,end), zeros(1,34), zeros(2000,1))
%% [Agac NitelikVektoru] = ID3(ikibinlik_etiketsiz, ikibinlik_sayi_etiketli(:,end), zeros(1,34), zeros(2000,1))
%% [Agac NitelikVektoru] = ID3(besyuzluk_etiketsiz, ikibinlik_sayi_etiketli(:,end), zeros(1,34), zeros(500,1))
%% [Agac NitelikVektoru] = ID3(besyuzluk_etiketsiz,besyuzluk_sinifvektoru_ikilik, zeros(1,34), zeros(500,1));

function [Agac NiteliklerVektoru] = ID3(VeriSeti, SiniflarVektoru, NiteliklerVektoru, AktifKayitVektoru)
Agac = struct;
%%
% NiteliklerVektoru de�i�keni nitelik s�tunlar�n�n aktif olup olmad���na
% dair bilgiyi tutar.
% 0' de�eri nitelik s�tunun aktif ve i�leme sokulmas� gerekti�ini ifade eder.
%
% 1' de�eri s�tunun art�k i�leme al�nmamas� gerekti�ini ifade eder.

% ka� adet nitelik s�tunu mevcut ve ka� adet kay�t mevcut
[KayitSayisi NitelikSayisi] = size(VeriSeti);

if (sum(AktifKayitVektoru) == KayitSayisi)
    % Aktif kay�t kalmam��, yani t�m sat�rlar i�lenmi�; devam etmeye gerek kalmad�.    
    return ;
end

%Nitelik s�tununda sadece bir de�er varsa, hesaplamaya katmaya gerek yoktur.
NiteliklerVektoru = TekDegerliNitelikleriEtkisizYap(VeriSeti, NiteliklerVektoru, AktifKayitVektoru);

% her bir aktif nitelik s�tunu i�in, nitelik s�tunu ve alt niteliklerine
% ait bilgiler bir yap� eleman�nda saklanmak �zere hesaplan�yor...
for i = 1: NitelikSayisi
    NitelikSutunlari(i).Adi= i;    
    if(NiteliklerVektoru(i) == 0) % nitelik s�tunu aktif i�leme al!
        NitelikSutunlari(i).AltNitelikler = ...  % alt nitelikleri bul
                NiteliginAltNitelikleri(VeriSeti(:,i), SiniflarVektoru, AktifKayitVektoru);
        NitelikSutunlari(i).NitelikEntropisi = ... % nitelik s�tununun  entropisini bul
                NitelikEntropisiniHesapla( NitelikSutunlari(i).AltNitelikler);
    end
end

OncekiDegerYok = true; % niteliklerin entropilerini kar��la�t�rmada �nceki veriyi saklar
NiteliklerTamamlandi = true;

% hangi s�tuna g�re dallanma yap�laca��n� bulal�m
for i = 1: NitelikSayisi    
    if(NiteliklerVektoru(i) == 0) % nitelik s�tunu aktif i�leme al
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

% nitelikler tamamlanm��, yani hepsi 1 yap�ld���nda program art�k devam
% etmemeli. t�m nitelik s�tunlar� i�lenmi� demektir. dolay�s�yla bir
% �stteki d�ng�de hi�bir nitelik s�tunu i�lenemei�tir. i�lem bitmi�tir.
if(NiteliklerTamamlandi)
    return;
end

% dallan�lacak s�tunu bulduk.
DallanilanNitelikSutunu = NitelikSutunlari(dallanmaindeksi);
nitelikleradedi = length(DallanilanNitelikSutunu.AltNitelikler); % bu s�tunda ka� tane alt nitelik var.
AltAgacIndeksi = 1; % alt a�a� olu�turmak i�in ilk indeks

%her seferinde bir yaprak ��k�yormu bakal�m
for h = 1: nitelikleradedi    
        if length (DallanilanNitelikSutunu.AltNitelikler(h).Siniflar) == 1 % sadece tek bir s�n�f var. yani yaprak.
            altAgac(AltAgacIndeksi).Sinif = DallanilanNitelikSutunu.AltNitelikler(h).Siniflar;
            altAgac(AltAgacIndeksi).NitelikAdi = DallanilanNitelikSutunu.AltNitelikler(h).AltNitelikAdi;
            altAgac(AltAgacIndeksi).AltAgac = struct;             
            % bu s�n�f i�in kay�t sat�rlar�n�n tekrar i�lenmemesi i�in
            % kapat�lmas� gerekiyor. "1" de�erine atanmalar� kapat�lmalar�
            % anlam�na geliyor.
            AktifKayitVektoru(DallanilanNitelikSutunu.AltNitelikler(h).Siniflar.Kayitlar) = 1; 
            AltAgacIndeksi = AltAgacIndeksi + 1;
        end
end

% t�m alt nitelikler yaprak ile sonu�lanabilir. 
% dolay�s�yla yukar�daki koddan sonra t�m AktifKay�tlar i�lenmeye
% kapat�labilir. bu durumda i�lenecek kay�t kalmaz ve s�n�fland�rma
% tamamlanm�� olur. dolay�s�yla program�n i�i bitmi�tir.
AktifKayitVektoruToplami  =sum(AktifKayitVektoru);
if (AktifKayitVektoruToplami == KayitSayisi)
    % Aktif kay�t kalmam�� devam etmeye gerek kalmad�.    
    return ;
end

% yaprak olmayan alt nitelikler i�in dallanma yap
for h = 1: nitelikleradedi
    if length (DallanilanNitelikSutunu.AltNitelikler(h).Siniflar) > 1 % birden fazla s�n�f var ise dallan
        vektor = ones(length(AktifKayitVektoru),1);        
        kayitlar = [];        
        for k = 1: length(DallanilanNitelikSutunu.AltNitelikler(h).Siniflar)
            kayitlar = [kayitlar DallanilanNitelikSutunu.AltNitelikler(h).Siniflar(k).Kayitlar];            
        end        
        % yeni i�lenen ve s�n�f� belli olan kayitlar� ve 
        % bu zamana dek i�lenmi� olan kayitlari i�lemeye kapatal�m        
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






