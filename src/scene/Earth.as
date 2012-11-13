/**
 * Created with IntelliJ IDEA.
 * User: dumand
 * Date: 05/11/12
 * Time: 11:22
 * To change this template use File | Settings | File Templates.
 */
package scene {
import aerys.minko.render.geometry.primitive.SphereGeometry;
import aerys.minko.render.material.basic.BasicMaterial;
import aerys.minko.render.resource.texture.TextureResource;
import aerys.minko.scene.node.Group;
import aerys.minko.scene.node.Mesh;
import aerys.minko.type.loader.TextureLoader;

public class Earth extends Group {

    [Embed("../../assets/world_diffuse.jpg")]
//		[Embed("../assets/world_diffuse_2.jpg")]
    private static const ASSET_WORLD_DIFFUSE:Class;

    private static const DEFAULT_SCALE:Number = 1.5;

    public function Earth(scale:Number = DEFAULT_SCALE) {

        var texture:TextureResource = TextureLoader.loadClass(ASSET_WORLD_DIFFUSE);

        var mesh:Mesh = new Mesh(new SphereGeometry(40), new BasicMaterial({diffuseMap:texture}));

        super(mesh);

        transform.appendUniformScale(scale);
    }
}
}
