% alt niteliklerin toplamýný verir
function total = toplam (AltNitelikler)

total = 0;

for i = 1: length(AltNitelikler);
    
    for h =1: length(AltNitelikler(i).Siniflar);
      total = AltNitelikler(i).Siniflar(h).adet + total;
    end
end
total
end
