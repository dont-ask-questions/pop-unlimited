function bitOR(a, b)
{
   var _loc1_ = a & 1 | b & 1;
   var _loc2_ = a >>> 1 | b >>> 1;
   return _loc2_ << 1 | _loc1_;
}
function bitXOR(a, b)
{
   var _loc1_ = a & 1 ^ b & 1;
   var _loc2_ = a >>> 1 ^ b >>> 1;
   return _loc2_ << 1 | _loc1_;
}
function bitAND(a, b)
{
   var _loc1_ = a & 1 & (b & 1);
   var _loc2_ = a >>> 1 & b >>> 1;
   return _loc2_ << 1 | _loc1_;
}
function addme(x, y)
{
   var _loc1_ = (x & 0xFFFF) + (y & 0xFFFF);
   var _loc2_ = (x >> 16) + (y >> 16) + (_loc1_ >> 16);
   return _loc2_ << 16 | _loc1_ & 0xFFFF;
}
function rhex(num)
{
   str = "";
   j = 0;
   while(j <= 3)
   {
      str += hex_chr.charAt(num >> j * 8 + 4 & 0x0F) + hex_chr.charAt(num >> j * 8 & 0x0F);
      j++;
   }
   return str;
}
function str2blks_MD5(str)
{
   nblk = (str.length + 8 >> 6) + 1;
   blks = new Array(nblk * 16);
   i = 0;
   while(i < nblk * 16)
   {
      blks[i] = 0;
      i++;
   }
   i = 0;
   while(i < str.length)
   {
      blks[i >> 2] |= str.charCodeAt(i) << (str.length * 8 + i) % 4 * 8;
      i++;
   }
   blks[i >> 2] |= 128 << (str.length * 8 + i) % 4 * 8;
   var _loc2_ = str.length * 8;
   blks[nblk * 16 - 2] = _loc2_ & 0xFF;
   blks[nblk * 16 - 2] |= (_loc2_ >>> 8 & 0xFF) << 8;
   blks[nblk * 16 - 2] |= (_loc2_ >>> 16 & 0xFF) << 16;
   blks[nblk * 16 - 2] |= (_loc2_ >>> 24 & 0xFF) << 24;
   return blks;
}
function rol(num, cnt)
{
   return num << cnt | num >>> 32 - cnt;
}
function cmn(q, a, b, x, s, t)
{
   return addme(rol(addme(addme(a,q),addme(x,t)),s),b);
}
function ff(a, b, c, d, x, s, t)
{
   return cmn(bitOR(bitAND(b,c),bitAND(~b,d)),a,b,x,s,t);
}
function gg(a, b, c, d, x, s, t)
{
   return cmn(bitOR(bitAND(b,d),bitAND(c,~d)),a,b,x,s,t);
}
function hh(a, b, c, d, x, s, t)
{
   return cmn(bitXOR(bitXOR(b,c),d),a,b,x,s,t);
}
function ii(a, b, c, d, x, s, t)
{
   return cmn(bitXOR(c,bitOR(b,~d)),a,b,x,s,t);
}
function calcMD5(str)
{
   x = str2blks_MD5(str);
   a = 1732584193;
   b = -271733879;
   c = -1732584194;
   d = 271733878;
   var _loc1_ = undefined;
   i = 0;
   while(i < x.length)
   {
      olda = a;
      oldb = b;
      oldc = c;
      oldd = d;
      _loc1_ = 0;
      a = ff(a,b,c,d,x[i + 0],7,-680876936);
      d = ff(d,a,b,c,x[i + 1],12,-389564586);
      c = ff(c,d,a,b,x[i + 2],17,606105819);
      b = ff(b,c,d,a,x[i + 3],22,-1044525330);
      a = ff(a,b,c,d,x[i + 4],7,-176418897);
      d = ff(d,a,b,c,x[i + 5],12,1200080426);
      c = ff(c,d,a,b,x[i + 6],17,-1473231341);
      b = ff(b,c,d,a,x[i + 7],22,-45705983);
      a = ff(a,b,c,d,x[i + 8],7,1770035416);
      d = ff(d,a,b,c,x[i + 9],12,-1958414417);
      c = ff(c,d,a,b,x[i + 10],17,-42063);
      b = ff(b,c,d,a,x[i + 11],22,-1990404162);
      a = ff(a,b,c,d,x[i + 12],7,1804603682);
      d = ff(d,a,b,c,x[i + 13],12,-40341101);
      c = ff(c,d,a,b,x[i + 14],17,-1502002290);
      b = ff(b,c,d,a,x[i + 15],22,1236535329);
      a = gg(a,b,c,d,x[i + 1],5,-165796510);
      d = gg(d,a,b,c,x[i + 6],9,-1069501632);
      c = gg(c,d,a,b,x[i + 11],14,643717713);
      b = gg(b,c,d,a,x[i + 0],20,-373897302);
      a = gg(a,b,c,d,x[i + 5],5,-701558691);
      d = gg(d,a,b,c,x[i + 10],9,38016083);
      c = gg(c,d,a,b,x[i + 15],14,-660478335);
      b = gg(b,c,d,a,x[i + 4],20,-405537848);
      a = gg(a,b,c,d,x[i + 9],5,568446438);
      d = gg(d,a,b,c,x[i + 14],9,-1019803690);
      c = gg(c,d,a,b,x[i + 3],14,-187363961);
      b = gg(b,c,d,a,x[i + 8],20,1163531501);
      a = gg(a,b,c,d,x[i + 13],5,-1444681467);
      d = gg(d,a,b,c,x[i + 2],9,-51403784);
      c = gg(c,d,a,b,x[i + 7],14,1735328473);
      b = gg(b,c,d,a,x[i + 12],20,-1926607734);
      a = hh(a,b,c,d,x[i + 5],4,-378558);
      d = hh(d,a,b,c,x[i + 8],11,-2022574463);
      c = hh(c,d,a,b,x[i + 11],16,1839030562);
      b = hh(b,c,d,a,x[i + 14],23,-35309556);
      a = hh(a,b,c,d,x[i + 1],4,-1530992060);
      d = hh(d,a,b,c,x[i + 4],11,1272893353);
      c = hh(c,d,a,b,x[i + 7],16,-155497632);
      b = hh(b,c,d,a,x[i + 10],23,-1094730640);
      a = hh(a,b,c,d,x[i + 13],4,681279174);
      d = hh(d,a,b,c,x[i + 0],11,-358537222);
      c = hh(c,d,a,b,x[i + 3],16,-722521979);
      b = hh(b,c,d,a,x[i + 6],23,76029189);
      a = hh(a,b,c,d,x[i + 9],4,-640364487);
      d = hh(d,a,b,c,x[i + 12],11,-421815835);
      c = hh(c,d,a,b,x[i + 15],16,530742520);
      b = hh(b,c,d,a,x[i + 2],23,-995338651);
      a = ii(a,b,c,d,x[i + 0],6,-198630844);
      d = ii(d,a,b,c,x[i + 7],10,1126891415);
      c = ii(c,d,a,b,x[i + 14],15,-1416354905);
      b = ii(b,c,d,a,x[i + 5],21,-57434055);
      a = ii(a,b,c,d,x[i + 12],6,1700485571);
      d = ii(d,a,b,c,x[i + 3],10,-1894986606);
      c = ii(c,d,a,b,x[i + 10],15,-1051523);
      b = ii(b,c,d,a,x[i + 1],21,-2054922799);
      a = ii(a,b,c,d,x[i + 8],6,1873313359);
      d = ii(d,a,b,c,x[i + 15],10,-30611744);
      c = ii(c,d,a,b,x[i + 6],15,-1560198380);
      b = ii(b,c,d,a,x[i + 13],21,1309151649);
      a = ii(a,b,c,d,x[i + 4],6,-145523070);
      d = ii(d,a,b,c,x[i + 11],10,-1120210379);
      c = ii(c,d,a,b,x[i + 2],15,718787259);
      b = ii(b,c,d,a,x[i + 9],21,-343485551);
      a = addme(a,olda);
      b = addme(b,oldb);
      c = addme(c,oldc);
      d = addme(d,oldd);
      i += 16;
   }
   return rhex(a) + rhex(b) + rhex(c) + rhex(d);
}
function hex_md5(s)
{
   return binl2hex(core_md5(str2binl(s),s.length * chrsz));
}
function b64_md5(s)
{
   return binl2b64(core_md5(str2binl(s),s.length * chrsz));
}
function str_md5(s)
{
   return binl2str(core_md5(str2binl(s),s.length * chrsz));
}
function hex_hmac_md5(key, data)
{
   return binl2hex(core_hmac_md5(key,data));
}
function b64_hmac_md5(key, data)
{
   return binl2b64(core_hmac_md5(key,data));
}
function str_hmac_md5(key, data)
{
   return binl2str(core_hmac_md5(key,data));
}
function md5_vm_test()
{
   return hex_md5("abc") == "900150983cd24fb0d6963f7d28e17f72";
}
function core_md5(x, len)
{
   x[len >> 5] |= 128 << len % 32;
   x[(len + 64 >>> 9 << 4) + 14] = len;
   var _loc4_ = 1732584193;
   var _loc3_ = -271733879;
   var _loc2_ = -1732584194;
   var _loc1_ = 271733878;
   var _loc5_ = 0;
   while(_loc5_ < x.length)
   {
      var _loc10_ = _loc4_;
      var _loc9_ = _loc3_;
      var _loc8_ = _loc2_;
      var _loc7_ = _loc1_;
      _loc4_ = md5_ff(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 0],7,-680876936);
      _loc1_ = md5_ff(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 1],12,-389564586);
      _loc2_ = md5_ff(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 2],17,606105819);
      _loc3_ = md5_ff(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 3],22,-1044525330);
      _loc4_ = md5_ff(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 4],7,-176418897);
      _loc1_ = md5_ff(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 5],12,1200080426);
      _loc2_ = md5_ff(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 6],17,-1473231341);
      _loc3_ = md5_ff(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 7],22,-45705983);
      _loc4_ = md5_ff(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 8],7,1770035416);
      _loc1_ = md5_ff(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 9],12,-1958414417);
      _loc2_ = md5_ff(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 10],17,-42063);
      _loc3_ = md5_ff(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 11],22,-1990404162);
      _loc4_ = md5_ff(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 12],7,1804603682);
      _loc1_ = md5_ff(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 13],12,-40341101);
      _loc2_ = md5_ff(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 14],17,-1502002290);
      _loc3_ = md5_ff(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 15],22,1236535329);
      _loc4_ = md5_gg(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 1],5,-165796510);
      _loc1_ = md5_gg(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 6],9,-1069501632);
      _loc2_ = md5_gg(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 11],14,643717713);
      _loc3_ = md5_gg(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 0],20,-373897302);
      _loc4_ = md5_gg(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 5],5,-701558691);
      _loc1_ = md5_gg(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 10],9,38016083);
      _loc2_ = md5_gg(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 15],14,-660478335);
      _loc3_ = md5_gg(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 4],20,-405537848);
      _loc4_ = md5_gg(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 9],5,568446438);
      _loc1_ = md5_gg(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 14],9,-1019803690);
      _loc2_ = md5_gg(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 3],14,-187363961);
      _loc3_ = md5_gg(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 8],20,1163531501);
      _loc4_ = md5_gg(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 13],5,-1444681467);
      _loc1_ = md5_gg(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 2],9,-51403784);
      _loc2_ = md5_gg(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 7],14,1735328473);
      _loc3_ = md5_gg(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 12],20,-1926607734);
      _loc4_ = md5_hh(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 5],4,-378558);
      _loc1_ = md5_hh(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 8],11,-2022574463);
      _loc2_ = md5_hh(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 11],16,1839030562);
      _loc3_ = md5_hh(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 14],23,-35309556);
      _loc4_ = md5_hh(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 1],4,-1530992060);
      _loc1_ = md5_hh(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 4],11,1272893353);
      _loc2_ = md5_hh(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 7],16,-155497632);
      _loc3_ = md5_hh(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 10],23,-1094730640);
      _loc4_ = md5_hh(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 13],4,681279174);
      _loc1_ = md5_hh(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 0],11,-358537222);
      _loc2_ = md5_hh(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 3],16,-722521979);
      _loc3_ = md5_hh(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 6],23,76029189);
      _loc4_ = md5_hh(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 9],4,-640364487);
      _loc1_ = md5_hh(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 12],11,-421815835);
      _loc2_ = md5_hh(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 15],16,530742520);
      _loc3_ = md5_hh(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 2],23,-995338651);
      _loc4_ = md5_ii(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 0],6,-198630844);
      _loc1_ = md5_ii(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 7],10,1126891415);
      _loc2_ = md5_ii(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 14],15,-1416354905);
      _loc3_ = md5_ii(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 5],21,-57434055);
      _loc4_ = md5_ii(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 12],6,1700485571);
      _loc1_ = md5_ii(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 3],10,-1894986606);
      _loc2_ = md5_ii(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 10],15,-1051523);
      _loc3_ = md5_ii(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 1],21,-2054922799);
      _loc4_ = md5_ii(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 8],6,1873313359);
      _loc1_ = md5_ii(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 15],10,-30611744);
      _loc2_ = md5_ii(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 6],15,-1560198380);
      _loc3_ = md5_ii(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 13],21,1309151649);
      _loc4_ = md5_ii(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 4],6,-145523070);
      _loc1_ = md5_ii(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 11],10,-1120210379);
      _loc2_ = md5_ii(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 2],15,718787259);
      _loc3_ = md5_ii(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 9],21,-343485551);
      _loc4_ = safe_add(_loc4_,_loc10_);
      _loc3_ = safe_add(_loc3_,_loc9_);
      _loc2_ = safe_add(_loc2_,_loc8_);
      _loc1_ = safe_add(_loc1_,_loc7_);
      _loc5_ += 16;
   }
   return Array(_loc4_,_loc3_,_loc2_,_loc1_);
}
function md5_cmn(q, a, b, x, s, t)
{
   return safe_add(bit_rol(safe_add(safe_add(a,q),safe_add(x,t)),s),b);
}
function md5_ff(a, b, c, d, x, s, t)
{
   return md5_cmn(b & c | (~b) & d,a,b,x,s,t);
}
function md5_gg(a, b, c, d, x, s, t)
{
   return md5_cmn(b & d | c & (~d),a,b,x,s,t);
}
function md5_hh(a, b, c, d, x, s, t)
{
   return md5_cmn(b ^ c ^ d,a,b,x,s,t);
}
function md5_ii(a, b, c, d, x, s, t)
{
   return md5_cmn(c ^ (b | ~d),a,b,x,s,t);
}
function core_hmac_md5(key, data)
{
   var _loc2_ = str2binl(key);
   if(_loc2_.length > 16)
   {
      _loc2_ = core_md5(_loc2_,key.length * chrsz);
   }
   var _loc3_ = Array(16);
   var _loc4_ = Array(16);
   var _loc1_ = 0;
   while(_loc1_ < 16)
   {
      _loc3_[_loc1_] = _loc2_[_loc1_] ^ 0x36363636;
      _loc4_[_loc1_] = _loc2_[_loc1_] ^ 0x5C5C5C5C;
      _loc1_ = _loc1_ + 1;
   }
   var _loc5_ = core_md5(_loc3_.concat(str2binl(data)),512 + data.length * chrsz);
   return core_md5(_loc4_.concat(_loc5_),640);
}
function safe_add(x, y)
{
   var _loc1_ = (x & 0xFFFF) + (y & 0xFFFF);
   var _loc2_ = (x >> 16) + (y >> 16) + (_loc1_ >> 16);
   return _loc2_ << 16 | _loc1_ & 0xFFFF;
}
function bit_rol(num, cnt)
{
   return num << cnt | num >>> 32 - cnt;
}
function str2binl(str)
{
   var _loc3_ = Array();
   var _loc4_ = (1 << chrsz) - 1;
   var _loc1_ = 0;
   while(_loc1_ < str.length * chrsz)
   {
      _loc3_[_loc1_ >> 5] |= (str.charCodeAt(_loc1_ / chrsz) & _loc4_) << _loc1_ % 32;
      _loc1_ += chrsz;
   }
   return _loc3_;
}
function binl2str(bin)
{
   var _loc3_ = "";
   var _loc4_ = (1 << chrsz) - 1;
   var _loc1_ = 0;
   while(_loc1_ < bin.length * 32)
   {
      _loc3_ += String.fromCharCode(bin[_loc1_ >> 5] >>> _loc1_ % 32 & _loc4_);
      _loc1_ += chrsz;
   }
   return _loc3_;
}
function binl2hex(binarray)
{
   var _loc3_ = !hexcase ? "0123456789abcdef" : "0123456789ABCDEF";
   var _loc4_ = "";
   var _loc1_ = 0;
   while(_loc1_ < binarray.length * 4)
   {
      _loc4_ += _loc3_.charAt(binarray[_loc1_ >> 2] >> _loc1_ % 4 * 8 + 4 & 0x0F) + _loc3_.charAt(binarray[_loc1_ >> 2] >> _loc1_ % 4 * 8 & 0x0F);
      _loc1_ = _loc1_ + 1;
   }
   return _loc4_;
}
function binl2b64(binarray)
{
   var _loc6_ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
   var _loc4_ = "";
   var _loc2_ = 0;
   while(_loc2_ < binarray.length * 4)
   {
      var _loc5_ = (binarray[_loc2_ >> 2] >> 8 * (_loc2_ % 4) & 0xFF) << 16 | (binarray[_loc2_ + 1 >> 2] >> 8 * ((_loc2_ + 1) % 4) & 0xFF) << 8 | binarray[_loc2_ + 2 >> 2] >> 8 * ((_loc2_ + 2) % 4) & 0xFF;
      var _loc1_ = 0;
      while(_loc1_ < 4)
      {
         if(_loc2_ * 8 + _loc1_ * 6 > binarray.length * 32)
         {
            _loc4_ += b64pad;
         }
         else
         {
            _loc4_ += _loc6_.charAt(_loc5_ >> 6 * (3 - _loc1_) & 0x3F);
         }
         _loc1_ = _loc1_ + 1;
      }
      _loc2_ += 3;
   }
   return _loc4_;
}
function init()
{
   gLSOWarningManager = new LSOWarningManager(_root,this,776,430);
   LSO = gLSOWarningManager.lso;
   LSO.data.numFriends = undefined;
   var _loc3_ = SharedObject.getLocal("Backup","/");
   _loc3_.data.login = undefined;
   _loc3_.data.password = undefined;
   _loc3_.flush();
   _loc3_.clear();
   trace("backup cleared : " + _loc3_.data.login);
   _root.tabChildren = true;
   stop();
   keyListener.onKeyDown = function()
   {
      if(Key.getCode() == 13 && !gPasswordReminderClip)
      {
         if(parentEmailReminder)
         {
            checkParentEmail();
         }
         else
         {
            authBtn.onRelease();
         }
      }
   };
   Key.addListener(keyListener);
   showForgotPasswordButton(false);
   Iname.tabIndex = 1;
   Ipass.tabIndex = 2;
   authBtn.tabIndex = 3;
   Iname.maxChars = 50;
   Ipass.maxChars = 50;
   authBtn.onRollOver = _root.useArrow;
   Iname.onChanged = Ipass.onChanged = function()
   {
      errorMsg.gotoAndStop("blank");
   };
   backBtn.onPress = function()
   {
      this._parent.gotoAndPlay("start");
   };
   backBtn.onRollOver = _root.useArrow;
   newBtn.onPress = function()
   {
      this._parent.MessageStripClip.play();
      this._parent.gotoAndPlay("new");
   };
   newBtn.onRollOver = _root.useArrow;
   loginHelpBtn.onPress = function()
   {
      getUrl("http://www.poptropica.com/Poptropica-FAQ.html#account.3", "_blank");
   };
   loginHelpBtn.onRollOver = _root.useArrow;
   forgotPasswordButton.onRollOver = _root.useArrow;
   forgotPasswordButton.onRelease = Delegate.create(this,showSendPasswordReminder);
   authBtn.onRelease = function()
   {
      if(Iname.text == "")
      {
         hideErrorMessage();
         errorMsg.gotoAndStop("name");
         return undefined;
      }
      if(!checkBadUsername(Iname.text))
      {
         if(!checkBadLogin(Iname.text,Ipass.text))
         {
            authBtn._visible = false;
            _root.takeClick._visible = true;
            gUserName = Iname.text;
            gPassHash = calcMD5(Ipass.text.toLowerCase());
            sender.login = gUserName;
            sender.pass_hash = gPassHash;
            sender.sendAndLoad(_root.getPrefix() + "/login.php",receiver,"POST");
         }
         else
         {
            hideErrorMessage();
            errorMsg.gotoAndStop("wrongpass");
         }
      }
      else
      {
         hideErrorMessage();
         errorMsg.gotoAndStop("noname");
      }
   };
}
function loadBase()
{
   if(_root.gActivityTimer)
   {
      _root.gActivityTimer.clearData();
   }
   if(utils.Utils.isNull(_root.exit.island))
   {
      trace("perf : island is null!  Setting default island of early...");
      _root.exit.island = "Early";
   }
   char.avatar.updateIslandData(_root.exit.island,Delegate.create(this,loadBaseInternal));
}
function loadBaseInternal()
{
   var _loc2_ = "LoginCompleted";
   var _loc3_ = LSO.data.age - 5;
   if(LSO.data.gender == 0)
   {
      CharacterGender = "F";
   }
   else
   {
      CharacterGender = "M";
   }
   loadVariablesNum("/brain/track.php?scene=" + _root.SceneName + "&event=" + _loc2_ + "&grade=" + _loc3_ + "&gender=" + CharacterGender + "&lang=" + _root.CharacterLanguage + "&brain=Poptropica&randomNumber=" + random(10000),0);
   _root.exit.getURL("base.php","_self","POST");
}
function revealErrorMessage()
{
   gWaitingForErrorMessage = false;
   errorMsg._visible = true;
   authBtn._visible = true;
   _root.takeClick._visible = false;
   _root.pointer.gotoAndStop("arrow");
}
function hideErrorMessage()
{
   if(!gWaitingForErrorMessage)
   {
      gWaitingForErrorMessage = true;
      authBtn._visible = false;
      errorMsg._visible = false;
      _root.takeClick._visible = true;
      setTimeout(revealErrorMessage,ERROR_MESSAGE_TIMEOUT);
   }
}
function showDBErrorDialog(error, connectionError)
{
   _root.pointer.gotoAndStop("arrow");
   authBtn._visible = true;
   _root.takeClick._visible = false;
   _root.pointer.gotoAndStop("arrow");
   gPasswordReminderClip = this.attachMovie("errorPopup","passwordReminder",this.getNextHighestDepth(),{_x:Stage.width * 0.5,_y:Stage.height * 0.5});
   if(connectionError)
   {
      gPasswordReminderClip.errorGraphic.gotoAndStop("connection");
   }
   gPasswordReminderClip.closeButton._visible = false;
   gPasswordReminderClip.label.text = error;
   gPasswordReminderClip.okButton.onRelease = function()
   {
      gPasswordReminderClip.removeMovieClip();
      gPasswordReminderClip = null;
   };
}
function showSendPasswordReminder()
{
   gPasswordReminderClip = this.attachMovie("passwordReminder","passwordReminder",this.getNextHighestDepth(),{_x:Stage.width * 0.5,_y:Stage.height * 0.5});
   gPasswordReminderClip.label.text = "Would you like to send an email with instructions to reset your password to the parent address associated with your account?";
   gPasswordReminderClip.okButton.onRelease = function()
   {
      showForgotPasswordButton(false);
      if(!gPasswordReminderSent)
      {
         gPasswordReminderSent = true;
         doSendReminder();
      }
      gPasswordReminderClip.removeMovieClip();
      gPasswordReminderClip = null;
   };
   gPasswordReminderClip.closeButton.onRelease = function()
   {
      gPasswordReminderClip.removeMovieClip();
      gPasswordReminderClip = null;
   };
}
function sendPasswordReminder()
{
   showForgotPasswordButton(false);
   gPasswordReminderClip = this.attachMovie("passwordReminder","passwordReminder",this.getNextHighestDepth(),{_x:Stage.width * 0.5,_y:Stage.height * 0.5});
   gPasswordReminderClip.closeButton._visible = false;
   gPasswordReminderClip.okButton.onRelease = function()
   {
      gPasswordReminderClip.removeMovieClip();
      gPasswordReminderClip = null;
   };
   if(!gPasswordReminderSent)
   {
      gPasswordReminderSent = true;
      doSendReminder();
   }
}
function doSendReminder()
{
   _root.takeClick._visible = true;
   sender = new LoadVars();
   sender.login = Iname.text;
   sender.pass_hash = gPassHashFromSender;
   sender.dbid = gDBID;
   sender.parent_email = gParentEmail;
   sender.action = "resetPasswordRequest";
   gSentReminderPopup = true;
   sender.sendAndLoad(_root.getPrefix() + "/store/password_recovery.php",gParentEmailReciever,"POST");
}
function showForgotPasswordButton(showNow)
{
   if(showNow == undefined)
   {
      showNow = true;
   }
   forgotPasswordButton._visible = showNow;
}
function checkErrorMessage(error, waitTime, message)
{
   if(!utils.Utils.isNull(message))
   {
      _root.trackCampaign("LoginError","AnswerInvalid",error);
      showDBErrorDialog(message);
      return undefined;
   }
   if(error == "nologin" || error.charAt(0) == "n")
   {
      errorMsg.gotoAndStop("noname");
   }
   else if(error == "wrongpass" || error.charAt(0) == "w")
   {
      if(gShowReminderButton)
      {
         showForgotPasswordButton();
      }
      if(Ipass.text == "")
      {
         errorMsg.gotoAndStop("pwd");
      }
      else
      {
         errorMsg.gotoAndStop("wrongpass");
      }
      if(waitTime != undefined && !isNaN(waitTime))
      {
         var _loc3_ = attachMovie("TimerPopup","timerPopup",1000,{startTime:getTimer(),timeToWait:waitTime});
         _loc3_.timerTxt.text = waitTime;
         _loc3_.tryMessage.text = waitTime;
         _loc3_.onEnterFrame = function()
         {
            var _loc2_ = Math.floor((getTimer() - this.startTime) / 1000);
            if(_loc2_ >= this.timeToWait)
            {
               this.removeMovieClip();
            }
            else
            {
               this.timerTxt.text = this.timeToWait - _loc2_;
            }
         };
         _loc3_.onPress = function()
         {
         };
         _loc3_.useHandCursor = false;
      }
   }
   else
   {
      _root.trackCampaign("LoginError","AnswerInvalid",error);
      showDBErrorDialog("OOOPS! You connected to Poptropica but there was an error. Please try again later or try a different web browser.");
   }
}
function showParentEmailReminder(type)
{
   _root.takeClick._visible = false;
   _root.pointer.gotoAndStop("arrow");
   var _loc3_ = this.attachMovie("parentEmailReminder","parentEmailReminder",this.getNextHighestDepth(),{_x:Stage.width * 0.5,_y:Stage.height * 0.5});
   if(type == "expired")
   {
      _loc3_.title.text = "The email address " + LSO.data.parentEmail + " has not responded to your request.  Would you like to try a different email?";
   }
   else if(type == "invalid")
   {
      _loc3_.title.text = "The email address " + LSO.data.parentEmail + " is not valid.  Would you like to try a different email?";
   }
   else
   {
      _loc3_.title.text = "Hey, " + Iname.text + "! Want the ability to recover a lost password? Enter a valid parent email address.";
   }
   _loc3_.noButton.onRelease = remindMeLater;
   _loc3_.yesButton.onRelease = checkParentEmail;
   _loc3_.IparentEmail.tabIndex = 1;
   _loc3_.IparentEmail.maxChars = 50;
}
function checkParentEmail()
{
   var _loc1_ = parentEmailReminder.IparentEmail.text;
   if(_loc1_ == "")
   {
      parentEmailReminder.out.text = "Please enter a Parent Email Address.";
      return undefined;
   }
   if(!checkEmailString(_loc1_))
   {
      parentEmailReminder.out.text = "The Parent Email address is not valid.";
      return undefined;
   }
   if(gParentEmail != _loc1_)
   {
      gParentEmail = _loc1_;
      parentEmailReminder.removeMovieClip();
      parentEmailAccepted();
   }
   parentEmailReminder.out.text = "";
}
function parentEmailAccepted()
{
   _root.takeClick._visible = true;
   sender = new LoadVars();
   sender.login = Iname.text;
   sender.pass_hash = gPassHash;
   sender.dbid = gDBID;
   sender.parent_email = gParentEmail;
   sender.action = "insertParentEmail";
   sender.sendAndLoad(_root.getPrefix() + "/store/password_recovery.php",gParentEmailReciever,"POST");
}
function remindMeLater()
{
   startGame();
}
function startGame()
{
   trace("startGame");
   parentEmailReminder.removeMovieClip();
   loadBase();
}
function checkEmailString(email)
{
   var _loc3_ = "^[^@ ]+\\@[-\\d\\w]+(\\.[-\\d\\w]+)+$";
   var _loc2_ = "gim";
   var _loc1_ = new RegExp(_loc3_,_loc2_);
   return _loc1_.test(email);
}
function addBadLogin(username, pass)
{
   if(!checkBadLogin(username,pass))
   {
      trace("Password Check :: Adding bad login : username : " + username + " pass : " + pass);
      gBadLogins.push({username:username,pass:pass});
   }
}
function addBadUsername(username)
{
   if(!checkBadUsername(username))
   {
      trace("Password Check :: Adding bad login : username : " + username);
      gBadUsernames.push(username);
   }
}
function checkBadLogin(username, pass)
{
   var _loc2_ = undefined;
   var _loc1_ = 0;
   while(_loc1_ < gBadLogins.length)
   {
      _loc2_ = gBadLogins[_loc1_];
      if(_loc2_.username == username && _loc2_.pass == pass)
      {
         trace("Password Check :: Bad Username and Password : username : " + username + " pass : " + pass);
         return true;
      }
      _loc1_ = _loc1_ + 1;
   }
   return false;
}
function checkBadUsername(username)
{
   var _loc1_ = 0;
   while(_loc1_ < gBadUsernames.length)
   {
      if(gBadUsernames[_loc1_] == username)
      {
         trace("Password Check :: Bad Username : username : " + username);
         return true;
      }
      _loc1_ = _loc1_ + 1;
   }
   return false;
}
stop();
var hex_chr = "0123456789abcdef";
var hexcase = 0;
var b64pad = "";
var chrsz = 8;
var jsonLib = new asLib.JSON();
var gAddParentEmailCredits = 50;
var gWaitingForErrorMessage = false;
var ERROR_MESSAGE_TIMEOUT = 1100;
var sender = new LoadVars();
var receiver = new LoadVars();
var gParentEmailReciever = new LoadVars();
var gUserName = Iname.text;
var gPassHash;
var gPassHashFromSender;
var gDBID;
var gPasswordReminderSent = false;
var gParentEmail;
var gSentReminderPopup = false;
var gPasswordReminderClip = null;
var gBadLogins = new Array();
var gBadUsernames = new Array();
var LSO;
var gLSOWarningManager;
var PARENT_EMAIL_REMINDER_FREQ = 3;
var EMAIL_REMINDER_ALLOWED = true;
var _loadUserResultVars;
var keyListener = new Object();
init();
receiver.onLoad = function(success)
{
   if(!success)
   {
      _root.trackCampaign("LoginError","FlashUnableToConnect");
      showDBErrorDialog("Adobe Flash was unable to establish a connection to Poptropica. Please try again later or try a different browser. If this continues, please check your network or try a different computer.",true);
      return undefined;
   }
   var _loc9_ = new asLib.JSON();
   var _loc4_ = undefined;
   if(this.json)
   {
      _loc4_ = _loc9_.parse(this.json);
   }
   var _loc7_ = this.message;
   this.message = null;
   gDBID = _loc4_.dbid;
   gParentEmail = _loc4_.parent_email;
   gPassHashFromSender = _loc4_.pass_hash;
   if(this.answer == "ok")
   {
      if(!utils.Utils.isNull(_loc7_))
      {
         showDBErrorDialog(_loc7_);
         return undefined;
      }
      var _loc10_ = _loc4_.look.split(",");
      char.avatar.gotoAndStop(1);
      char.avatar.saveLook(_loc10_);
      char.avatar.nextFrame();
      char.avatar.saveLogin(_loc4_.login);
      var _loc8_ = SharedObject.getLocal("Backup","/");
      _loc8_.data.login = _loc4_.login;
      _loc8_.data.password = LSO.data.password = sender.pass_hash;
      _loc8_.flush();
      lastIsland = _loc4_.island;
      lastRoom = _loc4_.last_room;
      if(lastRoom == undefined || lastRoom == "")
      {
         lastIsland = "Early";
         lastRoom = "City2";
      }
      else
      {
         LSO.data[lastRoom + "xPos"] = _loc4_.lastx;
         LSO.data[lastRoom + "yPos"] = _loc4_.lasty;
      }
      char.avatar.saveVisited(_loc4_.map);
      char.avatar.saveGames(_loc4_.games);
      LSO.data.firstName = _loc4_.firstname;
      LSO.data.lastName = _loc4_.lastname;
      LSO.data.age = _loc4_.age;
      var _loc6_ = _loc4_.scores.split("*");
      var _loc5_ = 0;
      while(_loc5_ < _loc6_.length)
      {
         var _loc3_ = _loc6_[_loc5_].split(";");
         LSO.data[_loc3_[0] + "Score"] = _loc3_[1];
         LSO.data[_loc3_[0] + "Wins"] = _loc3_[2];
         LSO.data[_loc3_[0] + "Losses"] = _loc3_[3];
         _loc5_ = _loc5_ + 1;
      }
      LSO.data.mem_status = _loc4_.memstatus;
      LSO.data.mem_date = _loc4_.memdate;
      LSO.data.mem_timestamp = new Date().getTime();
      if(_loc4_.userData)
      {
         LSO.data.userData = _loc9_.parse(unescape(_loc4_.userData));
      }
      LSO.data.Registred = true;
      LSO.data.dbid = _loc4_.dbid;
      _root.createEmptyMovieClip("exit",1);
      _root.exit.room = lastRoom;
      _root.exit.island = lastIsland;
      _root.exit.startup_path = "home";
      LSO.data.parentEmail = _loc4_.parent_email;
      LSO.data.parentEmailStatus = _loc4_.has_parent_email;
      LSO.data.dbid = _loc4_.dbid;
      var _loc11_ = gLSOWarningManager.flush(90000,Delegate.create(this,loadBase));
      if(_loc11_ == true)
      {
         if(_loc4_.has_parent_email == "None" || _loc4_.has_parent_email == "Rejected" || _loc4_.has_parent_email == undefined || _loc4_.has_parent_email == "" || _loc4_.has_parent_email == "null" || _loc4_.has_parent_email == null)
         {
            if(Math.floor(Math.random() * (PARENT_EMAIL_REMINDER_FREQ + 1)) == PARENT_EMAIL_REMINDER_FREQ && EMAIL_REMINDER_ALLOWED)
            {
               showParentEmailReminder();
            }
            else
            {
               loadBase();
            }
         }
         else if(_loc4_.has_parent_email == "Expired")
         {
            showParentEmailReminder("expired");
         }
         else
         {
            loadBase();
         }
      }
      else
      {
         authBtn._visible = true;
         _root.takeClick._visible = false;
         _root.pointer.gotoAndStop("arrow");
      }
   }
   else
   {
      if(this.answer == "nologin")
      {
         addBadUsername(Iname.text);
      }
      else if(this.answer == "wrongpass")
      {
         addBadLogin(Iname.text,Ipass.text);
      }
      authBtn._visible = true;
      _root.takeClick._visible = false;
      _root.pointer.gotoAndStop("arrow");
      if(_loc4_.has_parent_email == "Verified")
      {
         gShowReminderButton = true;
      }
      else
      {
         gShowReminderButton = false;
      }
      checkErrorMessage(this.answer,this.wait,_loc7_);
   }
};
gParentEmailReciever.onLoad = function()
{
   _root.takeClick._visible = false;
   _root.pointer.gotoAndStop("arrow");
   authBtn._visible = true;
   if(this.answer == "ok")
   {
      if(gSentReminderPopup)
      {
         gPasswordReminderSent = false;
         gSentReminderPopup = false;
         gPasswordReminderClip = _parent.attachMovie("passwordReminder","passwordReminder",this.getNextHighestDepth(),{_x:Stage.width * 0.5,_y:Stage.height * 0.5});
         gPasswordReminderClip.closeButton._visible = false;
         gPasswordReminderClip.label.text = "An email has been sent to your parent account with instructions to reset your password.";
         gPasswordReminderClip.okButton.onRelease = function()
         {
            gPasswordReminderClip.removeMovieClip();
            gPasswordReminderClip = null;
         };
      }
      else
      {
         LSO.data.parentEmailStatus = "Pending";
         LSO.data.parentEmail = gParentEmail;
         gLSOWarningManager.flush();
         startGame();
      }
   }
   else if(this.answer == "already_there")
   {
      gPasswordReminderClip = _parent.attachMovie("passwordReminder","passwordReminder",this.getNextHighestDepth(),{_x:Stage.width * 0.5,_y:Stage.height * 0.5});
      gPasswordReminderClip.label.text = "Thank you!  This email has been validated.";
      gPasswordReminderClip.closeButton._visible = false;
      gPasswordReminderClip.okButton.onRelease = function()
      {
         LSO.data.parentEmailStatus = "Verified";
         LSO.data.parentEmail = gParentEmail;
         gLSOWarningManager.flush();
         startGame();
         gPasswordReminderClip.removeMovieClip();
         gPasswordReminderClip = null;
      };
   }
   else if(this.answer == "InvalidEmail")
   {
      showParentEmailReminder("invalid");
      gPasswordReminderClip.removeMovieClip();
      gPasswordReminderClip = null;
   }
   else
   {
      gPasswordReminderClip = _parent.attachMovie("passwordReminder","passwordReminder",this.getNextHighestDepth(),{_x:Stage.width * 0.5,_y:Stage.height * 0.5});
      gPasswordReminderClip.closeButton._visible = false;
      if(gSentReminderPopup)
      {
         gPasswordReminderClip.label.text = "We were unable to save this email address. Please try again later.";
      }
      else
      {
         gPasswordReminderClip.label.text = "We were unable to save this email address. Please try again later.";
      }
      gPasswordReminderClip.okButton.onRelease = function()
      {
         startGame();
         gPasswordReminderClip.removeMovieClip();
         gPasswordReminderClip = null;
      };
   }
};
