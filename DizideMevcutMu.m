

%bir deðerin bir dizide mevcut olup olmadýðýný verir.
% mevcut ise TRUE, deðilse FALSE döndürür.
function mevcut = DizideMevcutMu(nitelikdegerleri, deger)
mevcut = false;

for z=1: length(nitelikdegerleri);
    if (deger == nitelikdegerleri(z))
        mevcut = true;
        return;
    end
end
end