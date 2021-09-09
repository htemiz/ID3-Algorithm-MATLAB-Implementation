
function AltNiteliklerDizisi = AltNiteliklerDizisiOlustur(NitelikSutunu, AktifKayitVektoru)

AltNiteliklerDizisi = [];

jj = 1;

% daha sonra tüm nitelik sütununu gezerek farklý olan deðerleri de alarak
% nitelikler dizisini oluþtur.
%
for i = 1 : length(NitelikSutunu)       % nitelik sütununda kaç deðer varsa
    if(AktifKayitVektoru(i) == 0)      % satýr iþlenmeye kapatýlmamýþsa hesaba dahil et!
        deger = NitelikSutunu(i);
        if ~DizideMevcutMu(AltNiteliklerDizisi, deger) % deðer dizide yoksa
            AltNiteliklerDizisi(jj) = deger;    %diziye bir eleman daha ekle
            jj = jj+1;
        end
    end
end
end
