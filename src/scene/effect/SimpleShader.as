/**
 * Created with IntelliJ IDEA.
 * User: dumand
 * Date: 06/11/12
 * Time: 08:23
 * To change this template use File | Settings | File Templates.
 */
package effect {
import aerys.minko.render.geometry.stream.format.VertexComponent;
import aerys.minko.render.shader.SFloat;
import aerys.minko.render.shader.Shader;

public class SimpleShader extends Shader {

    private var _color:SFloat = null;

    override protected function getVertexPosition():SFloat {
        var position:SFloat = getVertexAttribute(VertexComponent.XYZ);

        _color = getVertexAttribute(VertexComponent.RGB);

        return multiply4x4(localToScreen(position), projectionMatrix);
    }


    override protected function getPixelColor():SFloat {
        return interpolate(_color);
    }
}
}
