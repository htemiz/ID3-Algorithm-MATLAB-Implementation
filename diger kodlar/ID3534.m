function D = ID3(veriseti)









end


function Entropi = NitelikEntropisiBul(NitelikveEtiket)

nitelikDegerleri = NiteliktekiTumDegerleriBul(NitelikveEtiket(:,1));

Entropiler = zeros(length(nitelikDegerleri),1);



end




function nitelikdegerleri = NiteliktekiTumDegerleriBul(NitelikSutunu, EtiketSutunu)

% ilk deðeri nitelik sütunundan al.
nitelikdegerleri(1) = Niteliksutunu(1);
etiketdegerl







% daha sonra tüm nitelik sütununu gezerek farklý olan deðerleri de alarak
% nitelikler dizisini oluþtur.
for i = 2 : length(NitelikSutunu) % nitelik sütununda kaç deðer varsa
    deger = NitelikSutunu(i);
    
    %% nitelik deðeri daha evvel bulunmamýþsa diziye ekleniyor. 
    if ~any(deger, nitelikdegerleri) % deðer dizide yoksa
        nitelikdegerleri(length(nitelikdegerleri) + 1) = deger;  %diziye bir eleman daha ekle 
    end   
end
end





%% aranan deðer dizi içerisinde varsa true, yoksa false
%% döndürür
function  [mevcut] = icindeMevcut(deger, dizi)
mevcut = false;
for k= 1:length(dizi)    
    if(deger == dizi(k))
        mevcut = true;
        return;
    end
end
end