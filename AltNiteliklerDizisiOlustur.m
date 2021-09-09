
function AltNiteliklerDizisi = AltNiteliklerDizisiOlustur(NitelikSutunu, AktifKayitVektoru)

AltNiteliklerDizisi = [];

jj = 1;

% daha sonra t�m nitelik s�tununu gezerek farkl� olan de�erleri de alarak
% nitelikler dizisini olu�tur.
%
for i = 1 : length(NitelikSutunu)       % nitelik s�tununda ka� de�er varsa
    if(AktifKayitVektoru(i) == 0)      % sat�r i�lenmeye kapat�lmam��sa hesaba dahil et!
        deger = NitelikSutunu(i);
        if ~DizideMevcutMu(AltNiteliklerDizisi, deger) % de�er dizide yoksa
            AltNiteliklerDizisi(jj) = deger;    %diziye bir eleman daha ekle
            jj = jj+1;
        end
    end
end
end
