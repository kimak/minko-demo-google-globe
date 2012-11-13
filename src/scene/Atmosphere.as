package scene {
import aerys.minko.render.geometry.primitive.SphereGeometry;
import aerys.minko.render.material.Material;
import aerys.minko.scene.node.Group;
import aerys.minko.scene.node.Mesh;

public class Atmosphere extends Group {
    private static const DEFAULT_SCALE:Number = 200.;//233.;

    public function Atmosphere() {

        var material:Material = new Material();
//        material.effect=new GlowEffect(); need to test

        addChild(new Mesh(new SphereGeometry(40, 40), material));

        transform.appendUniformScale(DEFAULT_SCALE);
    }
}
}