package com.buchok {

  import flash.display.Sprite;
  import flash.events.*;
  import flash.net.*;
  import flash.external.ExternalInterface;

  public class Stream extends Sprite {

    function Stream() {
      addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
    }

    private function handleAddedToStage(event:Event) : void {
      var stream:URLStream = new URLStream();
      var url:String = root.loaderInfo.parameters.url;
      var request:URLRequest = new URLRequest(url);
      stream.addEventListener(Event.OPEN, handleStreamOpen);
      stream.addEventListener(ProgressEvent.PROGRESS, handleStreamProgress);
      stream.addEventListener(Event.COMPLETE, handleStreamComplete);
      stream.load(request);
    }

    private function handleStreamOpen(event:Event) : void {
      trace('stream opened ...');
    }

    private function handleStreamProgress(event:Event) : void {
      var stream:URLStream = event.target as URLStream;
      var chunk:String = stream.readUTFBytes(stream.bytesAvailable);
      log(chunk); // this will happen a lot!
    }

    private function handleStreamComplete(event:Event) : void {
      log('stream complete!');
    }

    // console.log
    private static const JS_TEST_FN:String = 'Function("return true;")';

    private static function log(... args) : void {
      if (jsAvailable())
        ExternalInterface.call("console.log", args.join(' '));
    }

    private static function jsAvailable() : Boolean {
      return ExternalInterface.available && ExternalInterface.call(JS_TEST_FN);
    }


  }
}