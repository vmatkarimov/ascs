package {

import flash.display.Shape;
import flash.display.Bitmap;
import flash.events.Event;
import flash.ui.Keyboard;

//  GameScreen
//
public class GameScreen extends Screen
{
  // Tile image:
  [Embed(source="../assets/tiles.png", mimeType="image/png")]
  private static const TilesImageCls:Class;
  private static const tilesimage:Bitmap = new TilesImageCls();

  // Map image:
  [Embed(source="../assets/map.png", mimeType="image/png")]
  private static const MapImageCls:Class;
  private static const mapimage:Bitmap = new MapImageCls();
  
  /// Game-related functions

  private var scene:Scene;
  private var player:Player;

  public function GameScreen(width:int, height:int)
  {
    var tilesize:int = 32;
    var tilemap:TileMap = new TileMap(mapimage.bitmapData, tilesize);
    scene = new Scene(width, height, tilemap, tilesimage.bitmapData);
    addChild(scene);

    player = new Player(scene);
    player.pos = tilemap.getTilePoint(3, 3);
    player.bounds = tilemap.getTileRect(3, 1, 1, 3);
    player.skin = createSkin(tilesize*1, tilesize*3, 0x44ff44);
    scene.add(player);

  }

  // open()
  public override function open():void
  {
  }

  // close()
  public override function close():void
  {
  }

  // update()
  public override function update():void
  {
    scene.update();
    scene.setCenter(player.pos, 100, 100);
    scene.paint();
  }

  // keydown(keycode)
  public override function keydown(keycode:int):void
  {
    switch (keycode) {
    case Keyboard.LEFT:
    case 65:			// A
    case 72:			// H
      player.dir.x = -1;
      break;

    case Keyboard.RIGHT:
    case 68:			// D
    case 76:			// L
      player.dir.x = +1;
      break;

    case Keyboard.UP:
    case 87:			// W
    case 75:			// K
      player.dir.y = -1;
      break;

    case Keyboard.DOWN:
    case 83:			// S
    case 74:			// J
      player.dir.y = +1;
      break;

    case Keyboard.SPACE:
    case Keyboard.ENTER:
    case 88:			// X
    case 90:			// Z
      player.action();
      break;

    }
  }

  // keyup(keycode)
  public override function keyup(keycode:int):void 
  {
    switch (keycode) {
    case Keyboard.LEFT:
    case Keyboard.RIGHT:
    case 65:			// A
    case 68:			// D
    case 72:			// H
    case 76:			// L
      player.dir.x = 0;
      break;

    case Keyboard.UP:
    case Keyboard.DOWN:
    case 87:			// W
    case 75:			// K
    case 83:			// S
    case 74:			// J
      player.dir.y = 0;
      break;
    }
  }

  // createSkin(w, h, color)
  public static function createSkin(w:int, h:int, color:uint):Shape
  {
    var shape:Shape = new Shape();
    shape.graphics.beginFill(color);
    shape.graphics.drawRect(0, 0, w, h);
    shape.graphics.endFill();
    return shape;
  }
}

} // package