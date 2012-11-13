/**
 * Created with IntelliJ IDEA.
 * User: dumand
 * Date: 05/11/12
 * Time: 11:19
 * To change this template use File | Settings | File Templates.
 */
package scene {
import aerys.minko.render.Effect;
import aerys.minko.render.material.Material;
import aerys.minko.scene.node.Group;
import aerys.minko.scene.node.Mesh;

import effect.SimpleShader;

import scene.mesh.PointsCloudGeometry;

public class Globe extends Group {

    private static const DEFAULT_SCALE:Number = .003;


    public function init(datas:Array):void {
        addChild(new Mesh(new PointsCloudGeometry(datas), new Material(new Effect(new SimpleShader()))));
        this.transform.appendUniformScale(DEFAULT_SCALE);
    }
}
}
