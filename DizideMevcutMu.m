

%bir de�erin bir dizide mevcut olup olmad���n� verir.
% mevcut ise TRUE, de�ilse FALSE d�nd�r�r.
function mevcut = DizideMevcutMu(nitelikdegerleri, deger)
mevcut = false;

for z=1: length(nitelikdegerleri);
    if (deger == nitelikdegerleri(z))
        mevcut = true;
        return;
    end
end
end