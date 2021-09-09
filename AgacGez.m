% Ana programdan elde edilen a�a� yap�s�ndaki sonu�lar
% tek tek alt dallar ve yapraklara kadar gezilerek metin dosyas�na karar
% a�ac� �eklinde yaz�l�yor.
%Metin = AgacGez(Agac, '');
function Metin = AgacGez(Agac, ustYazi)
    Metin = {}; % dosyaya yazd�r�lacak metin.
    
    
    altAgac = Agac.AltAgac; % bu a�ac�n alt dallar� veya yapraklar�
    altYazi ='';
    
    if  isfield(Agac, 'AgacinAdi') % bu alan varsa bir s�tuna g�re dallanma devam ediyor demektir.
        altYazi = strcat(' S�tun(',' ', num2str(Agac.AgacinAdi), ')  ');
    else
        altYazi = strcat([' ', num2str(Agac.NitelikAdi)], ' ise VE ');
    end

% bu dalda alt bir dal daha var m�? Var ise o alt dala da yinelemeli olarak
% dallanma yap�larak, en u�ta bir yaprak bulununcaya dek alt dallara
% dallanma devam ediyor.
if isempty(fields (Agac.AltAgac)) % a�ac�n alt d���m� yok. bu bir yaprakt�r.
    % buraya dek olan �st yaz� ile birlikte bu yapra��n s�n�f bilgisi
    % birle�tirilerek metin dosyas�na yaz�lacak olan karar c�mlesi haz�rlanm�� oluyor.
    for h= 1: length(Agac.Sinif)
        str = [ustYazi altYazi(1: end -3 ) ' S�n�f : ' num2str(Agac.Sinif(h).adi) '.'];
        
        Metin{(length(Metin) +1)} = {str};
        
        %dosyaya yaz
        fid = fopen('Agac.txt', 'at');
        fprintf(fid, strcat(str, '\n'));        
        fclose(fid);
    end
    
% bu dal�n alt dallar� da mevcut; alt dala yinelemeli dallanma yapmaya
% devam et
else % a�ac�n alt dallar� da vard�r.    
    for h=1: length(Agac.AltAgac)        
         AgacGez(Agac.AltAgac(h), strcat(ustYazi, altYazi));        
    end
end

end
