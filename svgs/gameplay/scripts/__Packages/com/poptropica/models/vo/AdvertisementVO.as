class com.poptropica.models.vo.AdvertisementVO
{
   var _campaign_name;
   var _click_through_URL;
   var _impression_URL;
   var _campaign_file1;
   var _campaign_file2;
   var _frequency_cap_count;
   var _frequency_cap_period;
   var _repeatSpacing;
   var _frequency_cap_num_visits;
   var _frequency_cap_first_visit;
   function AdvertisementVO(pCam, pClickThru, pImpression, pCampFile1, pCampFile2, pFrequencyCapCount, pFrequencyCapPeriod, pRepeatSpacing, pFrequencyCapNumVisits, pFrequencyCapFirstVisit)
   {
      this._campaign_name = pCam;
      this._click_through_URL = pClickThru;
      this._impression_URL = pImpression;
      this._campaign_file1 = pCampFile1;
      this._campaign_file2 = pCampFile2;
      this._frequency_cap_count = pFrequencyCapCount;
      if(this._frequency_cap_count == null || this._frequency_cap_count == undefined || isNaN(this._frequency_cap_count))
      {
         this._frequency_cap_count = 0;
      }
      this._frequency_cap_period = pFrequencyCapPeriod;
      this._repeatSpacing = Number(pRepeatSpacing);
      this._frequency_cap_num_visits = pFrequencyCapNumVisits;
      this._frequency_cap_first_visit = pFrequencyCapFirstVisit;
   }
   function get campaign_name()
   {
      return this._campaign_name;
   }
   function get click_through_URL()
   {
      return this._click_through_URL;
   }
   function get impression_URL()
   {
      return this._impression_URL;
   }
   function get campaign_file1()
   {
      return this._campaign_file1;
   }
   function get campaign_file2()
   {
      return this._campaign_file2;
   }
   function get frequency_cap_count()
   {
      return this._frequency_cap_count;
   }
   function get frequency_cap_period()
   {
      return this._frequency_cap_period;
   }
   function get campaign_repeat_spacing()
   {
      return this._repeatSpacing;
   }
   function get frequency_cap_num_visits()
   {
      return this._frequency_cap_num_visits;
   }
   function get frequency_cap_first_visit()
   {
      return this._frequency_cap_first_visit;
   }
   function set campaign_name(p)
   {
      this._campaign_name = p;
   }
   function set click_through_URL(p)
   {
      this._click_through_URL = p;
   }
   function set impression_URL(p)
   {
      this._impression_URL = p;
   }
   function set campaign_file1(p)
   {
      this._campaign_file1 = p;
   }
   function set campaign_file2(p)
   {
      this._campaign_file2 = p;
   }
   function set frequency_cap_count(p)
   {
      this._frequency_cap_count = p;
   }
   function set frequency_cap_period(p)
   {
      this._frequency_cap_period = p;
   }
   function set campaign_repeat_spacing(p)
   {
      this._repeatSpacing = p;
   }
   function set frequency_cap_num_visits(p)
   {
      this._frequency_cap_num_visits = p;
   }
   function set frequency_cap_first_visit(p)
   {
      this._frequency_cap_first_visit = p;
   }
}
