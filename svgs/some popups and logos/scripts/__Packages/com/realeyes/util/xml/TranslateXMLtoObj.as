class com.realeyes.util.xml.TranslateXMLtoObj
{
   var _singleNodes;
   var sFirstChild;
   var _propObjects;
   var _parseSimpleNode;
   static var _instance;
   static var className = "TranslateXMLtoObj";
   function TranslateXMLtoObj()
   {
      this.init();
   }
   static function getInstance()
   {
      if(com.realeyes.util.xml.TranslateXMLtoObj._instance == undefined)
      {
         com.realeyes.util.xml.TranslateXMLtoObj._instance = new com.realeyes.util.xml.TranslateXMLtoObj();
      }
      return com.realeyes.util.xml.TranslateXMLtoObj._instance;
   }
   function init()
   {
      this._singleNodes = new Array();
   }
   static function getIdMapFromNode(p_xml)
   {
      return new XML(p_xml.toString()).idMap;
   }
   function checkSingleNodes(p_nodeName)
   {
      var _loc3_ = this.singleNodes.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this.singleNodes[_loc2_].toUpperCase() == p_nodeName.toUpperCase())
         {
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function hasAttributes(p_node)
   {
      var _loc1_ = false;
      for(var _loc3_ in p_node.attributes)
      {
         _loc1_ = true;
         break;
      }
      return _loc1_;
   }
   function firstIsNotZero(p_value)
   {
      var _loc1_ = p_value.split("",1)[0];
      if(Number(_loc1_) == 0)
      {
         return false;
      }
      return true;
   }
   function buildObject(iNode)
   {
      var _loc4_ = new Object();
      var _loc5_ = undefined;
      var _loc3_ = undefined;
      while(iNode != null)
      {
         _loc5_ = new Object();
         _loc3_ = iNode.nodeName;
         if(!this.hasAttributes(iNode) && iNode.firstChild.nodeType == 3 && iNode.childNodes.length == 1 && !this.parseSimpleNode)
         {
            if(_loc4_[_loc3_] != undefined)
            {
               if(!(_loc4_[_loc3_] instanceof Array))
               {
                  _loc4_[_loc3_] = new Array(_loc4_[_loc3_]);
                  _loc4_[_loc3_].push(iNode.firstChild.nodeValue);
               }
               else
               {
                  _loc4_[_loc3_].push(iNode.firstChild.nodeValue);
               }
            }
            else
            {
               _loc4_[_loc3_] = iNode.firstChild.nodeValue;
            }
         }
         else
         {
            _loc5_ = this.buildObject(iNode.firstChild);
            _loc5_.nodeName = _loc3_;
            if(iNode.firstChild.nodeValue)
            {
               _loc5_.nodeValue = iNode.firstChild.nodeValue;
            }
            for(var _loc6_ in iNode.attributes)
            {
               if(this.firstIsNotZero(iNode.attributes[_loc6_]) && Math.abs(Number(iNode.attributes[_loc6_])) || Number(iNode.attributes[_loc6_]) == 0)
               {
                  _loc5_[_loc6_] = Number(iNode.attributes[_loc6_]);
               }
               else
               {
                  _loc5_[_loc6_] = iNode.attributes[_loc6_];
               }
            }
            if(this.propObjects && iNode.nodeName.toUpperCase() == "PROP")
            {
               _loc4_[iNode.attributes.id] = iNode.firstChild.nodeValue;
            }
            else if(_loc4_[_loc3_] != undefined)
            {
               if(_loc4_[_loc3_].length == undefined)
               {
                  _loc4_[_loc3_] = new Array(_loc4_[_loc3_]);
                  _loc4_[_loc3_].push(_loc5_);
               }
               else
               {
                  _loc4_[_loc3_].push(_loc5_);
               }
            }
            else if(this.checkSingleNodes(_loc3_) && _loc3_ != this.sFirstChild)
            {
               _loc4_[_loc3_] = new Array(_loc4_[_loc3_]);
               _loc4_[_loc3_][0] = _loc5_;
            }
            else if(_loc3_)
            {
               _loc4_[_loc3_] = _loc5_;
            }
         }
         iNode = iNode.nextSibling;
      }
      return _loc4_;
   }
   function parseToObject(p_xml)
   {
      p_xml.ignoreWhite = true;
      this.sFirstChild = p_xml.firstChild.nodeName;
      return this.buildObject(p_xml.firstChild);
   }
   function parseNodeToObject(p_xmlNode)
   {
      this.sFirstChild = p_xmlNode.nodeName;
      return this.buildObject(p_xmlNode);
   }
   function get singleNodes()
   {
      return this._singleNodes;
   }
   function set singleNodes(p_value)
   {
      this._singleNodes = p_value;
      trace("_singleNodes: " + p_value);
   }
   function get propObjects()
   {
      return this._propObjects;
   }
   function set propObjects(p_value)
   {
      this._propObjects = p_value;
   }
   function get parseSimpleNode()
   {
      return this._parseSimpleNode;
   }
   function set parseSimpleNode(p_value)
   {
      this._parseSimpleNode = p_value;
   }
}
