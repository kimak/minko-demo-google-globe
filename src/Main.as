/**
 * Created with IntelliJ IDEA.
 * User: dumand
 * Date: 05/11/12
 * Time: 10:52
 * To change this template use File | Settings | File Templates.
 */
package {
import aerys.qark.Qark;

import flash.events.Event;

import scene.Atmosphere;

import scene.Earth;
import scene.Globe;

public class Main extends MinkoExampleApplication {

    [Embed("../assets/search.qark", mimeType="application/octet-stream")]
    private static const ASSET_SEARCH_QARK:Class;
    [Embed("../assets/population2000.qark", mimeType="application/octet-stream")]
    private static const ASSET_POPULATION_QARK:Class;

    private var _globe:Globe = new Globe();

    private static const COLORS					: Array		= [0xd9d9d9, 0xb6b4b5, 0x9966cc, 0x15adff, 0x3e66a3,
        0x216288, 0xff7e7e, 0xff1f13, 0xc0120b, 0x5a1301,
        0xffcc02, 0xedb113, 0x9fce66, 0x0c9a39, 0xfe9872,
        0x7f3f98, 0xf26522, 0x2bb673, 0xd7df23, 0xe6b23a,
        0x7ed3f7];

    override protected function initializeScene():void {
        super.initializeScene();

        _scene.addChild(new Earth());
        _scene.addChild(new Atmosphere());
        _scene.addChild(_globe);

        loadPopulationData();
//        loadSearchData();
    }

    private function loadSearchData() : void
    {
        var decodedDatas		: Array	= Qark.decode(new ASSET_SEARCH_QARK());
        var numPoints 	: int 	= decodedDatas.length;
        var j			: int	= 0;


        var datas:Array=new Array(numPoints);

        var i:int=0, nb:int=numPoints;
        for(i;i<nb;++i)
        {
            var color:uint=COLORS[decodedDatas[i][3]];

            datas[i]=new Array(4);
            datas[i][0]=decodedDatas[i][0];
            datas[i][1]=decodedDatas[i][1];
            datas[i][2]=decodedDatas[i][2]*130;
            datas[i][3]=color;
        }

        _globe.init(datas);

    }

    private function loadPopulationData():void {
        var decodedDatas:Array = Qark.decode(new ASSET_POPULATION_QARK());

        var datas:Array=new Array(decodedDatas.length);

        var i:int=0, nb:int=decodedDatas.length;
        for(i;i<nb;++i)
        {

            var color:uint=ColorUtils.hsvToRgb(.6 - (decodedDatas[i][2] * .5), 1., 1.);

            datas[i]=new Array(4);
//            datas[i]=[decodedDatas[i][0],decodedDatas[i][1],decodedDatas[i][2]*130,color];
            datas[i][0]=decodedDatas[i][0];
            datas[i][1]=decodedDatas[i][1];
            datas[i][2]=decodedDatas[i][2]*130;
            datas[i][3]=color;
        }

        _globe.init(datas);
    }

    override protected function enterFrameHandler(event:Event):void {
        super.enterFrameHandler(event);
    }
}
}
