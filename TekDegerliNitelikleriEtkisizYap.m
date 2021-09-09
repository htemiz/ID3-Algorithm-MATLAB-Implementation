% bir nitelik s�tununda sadece bir de�er varsa, hesaplama a��s�ndan etkisi
% olmayacakt�r. bu nedenle tek de�ere sabit nitelik s�tunlar� i�in 
% NiteliklerVektoru i�inde ilgili s�tuna kar��l�k gelen de�er 1 olarak
% i�aretleniyor. B�ylece nitelik s�tunu pasif hale getiriliyor.
function NiteliklerVektoru = TekDegerliNitelikleriEtkisizYap(VeriSeti, NiteliklerVektoru, AktifKayitVektoru)

[KayitSayisi NitelikSayisi] = size(VeriSeti);

for i = 1 : NitelikSayisi
    NitelikSutunu = VeriSeti(:,i);
    AltNiteliklerDizisi = AltNiteliklerDizisiOlustur(NitelikSutunu, AktifKayitVektoru);
    if length(AltNiteliklerDizisi) < 2  % bu s�tunda sadece bir de�i�ken var demektir. bu s�tun etkisizdir.
        NiteliklerVektoru(i) = 1; % nitelik vekt�r� bu s�tun i�in 1 yap�ld�
    end
end
end