class com.greensock.core.PropTween
{
   var target;
   var property;
   var start;
   var change;
   var name;
   var isPlugin;
   var nextNode;
   var priority;
   function PropTween(target, property, start, change, name, isPlugin, nextNode, priority)
   {
      this.target = target;
      this.property = property;
      this.start = start;
      this.change = change;
      this.name = name;
      this.isPlugin = isPlugin;
      if(nextNode)
      {
         nextNode.prevNode = this;
         this.nextNode = nextNode;
      }
      this.priority = priority || 0;
   }
}
