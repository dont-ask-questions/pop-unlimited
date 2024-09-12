class com.poptropica.models.vo.IslandVO
{
   var _name;
   var _cluster_name;
   var _island_main;
   var _medallion;
   var _init_coords;
   function IslandVO(pName, pClusterName, pIslandMain, pMedallion, pCoords)
   {
      this._name = pName;
      this._cluster_name = pClusterName;
      this._island_main = pIslandMain;
      this._medallion = pMedallion;
      this._init_coords = pCoords;
   }
   function get name()
   {
      return this._name;
   }
   function get cluster_name()
   {
      return this._cluster_name;
   }
   function get island_main()
   {
      return this._island_main;
   }
   function get medallion()
   {
      return this._medallion;
   }
   function get init_coords()
   {
      return this._init_coords;
   }
   function set name(p)
   {
      this._name = p;
   }
   function set cluster_name(p)
   {
      this._cluster_name = p;
   }
   function set island_main(p)
   {
      this._island_main = p;
   }
   function set medallion(p)
   {
      this._medallion = p;
   }
   function set init_coords(p)
   {
      this._init_coords = p;
   }
}
