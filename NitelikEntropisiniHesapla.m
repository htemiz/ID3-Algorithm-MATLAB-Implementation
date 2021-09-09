
% bir nitelik s�tununa ait genel entropiyi hesaplar
% entropinin b�y�k olmas� dallanma i�in bu s�tunun uygun oldu�unu belirtir.
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
