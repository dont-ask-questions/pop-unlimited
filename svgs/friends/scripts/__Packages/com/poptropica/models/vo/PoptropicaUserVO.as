class com.poptropica.models.vo.PoptropicaUserVO
{
   var _login;
   var _password_hash;
   var _age;
   var _grade;
   var _gender;
   var _language;
   function PoptropicaUserVO(pLogin, pPasswordHash, pAge, pGrade, pGender, pLanguage)
   {
      this._login = pLogin;
      this._password_hash = pPasswordHash;
      this._age = pAge;
      this._grade = pGrade;
      this._gender = pGender;
      this._language = pLanguage;
   }
   function get login()
   {
      return this._login;
   }
   function get password_hash()
   {
      return this._password_hash;
   }
   function get gender()
   {
      return this._gender;
   }
   function get language()
   {
      return this._language;
   }
   function get age()
   {
      return this._age;
   }
   function get grade()
   {
      return this._grade;
   }
   function set login(p)
   {
      this._login = p;
   }
   function set password_hash(p)
   {
      this._password_hash = p;
   }
   function set gender(p)
   {
      this._gender = p;
   }
   function set language(p)
   {
      this._language = p;
   }
   function set age(p)
   {
      this._age = p;
   }
   function set grade(p)
   {
      this._grade = p;
   }
}
