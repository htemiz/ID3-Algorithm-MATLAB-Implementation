
% bir nitelik sütununa ait genel entropiyi hesaplar
% entropinin büyük olmasý dallanma için bu sütunun uygun olduðunu belirtir.
function NitelikEntropisi = NitelikEntropisiniHesapla( AltNitelikler)
toplam = 0;
NitelikEntropisi = 0;

for h = 1: length(AltNitelikler)
    toplam = AltNitelikler(h).ToplamAdet + toplam;
end


for h = 1: length(AltNitelikler)
    NitelikEntropisi = NitelikEntropisi + AltNitelikler(h).ToplamAdet * AltNitelikler(h).Entropi;
end

NitelikEntropisi= NitelikEntropisi / toplam;

end
