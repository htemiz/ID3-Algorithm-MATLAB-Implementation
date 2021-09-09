function D = ID3(veriseti)









end


function Entropi = NitelikEntropisiBul(NitelikveEtiket)

nitelikDegerleri = NiteliktekiTumDegerleriBul(NitelikveEtiket(:,1));

Entropiler = zeros(length(nitelikDegerleri),1);



end




function nitelikdegerleri = NiteliktekiTumDegerleriBul(NitelikSutunu, EtiketSutunu)

% ilk de�eri nitelik s�tunundan al.
nitelikdegerleri(1) = Niteliksutunu(1);
etiketdegerl







% daha sonra t�m nitelik s�tununu gezerek farkl� olan de�erleri de alarak
% nitelikler dizisini olu�tur.
for i = 2 : length(NitelikSutunu) % nitelik s�tununda ka� de�er varsa
    deger = NitelikSutunu(i);
    
    %% nitelik de�eri daha evvel bulunmam��sa diziye ekleniyor. 
    if ~any(deger, nitelikdegerleri) % de�er dizide yoksa
        nitelikdegerleri(length(nitelikdegerleri) + 1) = deger;  %diziye bir eleman daha ekle 
    end   
end
end





%% aranan de�er dizi i�erisinde varsa true, yoksa false
%% d�nd�r�r
function  [mevcut] = icindeMevcut(deger, dizi)
mevcut = false;
for k= 1:length(dizi)    
    if(deger == dizi(k))
        mevcut = true;
        return;
    end
end
end