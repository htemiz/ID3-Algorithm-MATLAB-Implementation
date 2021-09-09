% bir nitelik sütununda sadece bir deðer varsa, hesaplama açýsýndan etkisi
% olmayacaktýr. bu nedenle tek deðere sabit nitelik sütunlarý için 
% NiteliklerVektoru içinde ilgili sütuna karþýlýk gelen deðer 1 olarak
% iþaretleniyor. Böylece nitelik sütunu pasif hale getiriliyor.
function NiteliklerVektoru = TekDegerliNitelikleriEtkisizYap(VeriSeti, NiteliklerVektoru, AktifKayitVektoru)

[KayitSayisi NitelikSayisi] = size(VeriSeti);

for i = 1 : NitelikSayisi
    NitelikSutunu = VeriSeti(:,i);
    AltNiteliklerDizisi = AltNiteliklerDizisiOlustur(NitelikSutunu, AktifKayitVektoru);
    if length(AltNiteliklerDizisi) < 2  % bu sütunda sadece bir deðiþken var demektir. bu sütun etkisizdir.
        NiteliklerVektoru(i) = 1; % nitelik vektörü bu sütun için 1 yapýldý
    end
end
end