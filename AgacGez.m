% Ana programdan elde edilen aðaç yapýsýndaki sonuçlar
% tek tek alt dallar ve yapraklara kadar gezilerek metin dosyasýna karar
% aðacý þeklinde yazýlýyor.
%Metin = AgacGez(Agac, '');
function Metin = AgacGez(Agac, ustYazi)
    Metin = {}; % dosyaya yazdýrýlacak metin.
    
    
    altAgac = Agac.AltAgac; % bu aðacýn alt dallarý veya yapraklarý
    altYazi ='';
    
    if  isfield(Agac, 'AgacinAdi') % bu alan varsa bir sütuna göre dallanma devam ediyor demektir.
        altYazi = strcat(' Sütun(',' ', num2str(Agac.AgacinAdi), ')  ');
    else
        altYazi = strcat([' ', num2str(Agac.NitelikAdi)], ' ise VE ');
    end

% bu dalda alt bir dal daha var mý? Var ise o alt dala da yinelemeli olarak
% dallanma yapýlarak, en uçta bir yaprak bulununcaya dek alt dallara
% dallanma devam ediyor.
if isempty(fields (Agac.AltAgac)) % aðacýn alt düðümü yok. bu bir yapraktýr.
    % buraya dek olan üst yazý ile birlikte bu yapraðýn sýnýf bilgisi
    % birleþtirilerek metin dosyasýna yazýlacak olan karar cümlesi hazýrlanmýþ oluyor.
    for h= 1: length(Agac.Sinif)
        str = [ustYazi altYazi(1: end -3 ) ' Sýnýf : ' num2str(Agac.Sinif(h).adi) '.'];
        
        Metin{(length(Metin) +1)} = {str};
        
        %dosyaya yaz
        fid = fopen('Agac.txt', 'at');
        fprintf(fid, strcat(str, '\n'));        
        fclose(fid);
    end
    
% bu dalýn alt dallarý da mevcut; alt dala yinelemeli dallanma yapmaya
% devam et
else % aðacýn alt dallarý da vardýr.    
    for h=1: length(Agac.AltAgac)        
         AgacGez(Agac.AltAgac(h), strcat(ustYazi, altYazi));        
    end
end

end
