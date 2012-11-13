package scene.mesh {
import aerys.minko.render.geometry.Geometry;
import aerys.minko.render.geometry.stream.IVertexStream;
import aerys.minko.render.geometry.stream.IndexStream;
import aerys.minko.render.geometry.stream.StreamUsage;
import aerys.minko.render.geometry.stream.VertexStream;
import aerys.minko.render.geometry.stream.format.VertexComponent;
import aerys.minko.render.geometry.stream.format.VertexFormat;
import aerys.minko.render.geometry.stream.iterator.VertexIterator;
import aerys.minko.type.math.Matrix4x4;
import aerys.minko.type.math.Vector4;

public class PointsCloudGeometry extends Geometry {

    private static const NUM_POINTS_PER_MESH:uint = 8000;

    private static const TMP_VERTICES:Vector.<Number> = new Vector.<Number>();
    private static const INDICES:Vector.<uint> = Vector.<uint>([
        5, 7, 6, 5, 4, 7, 0, 4, 5, 0, 5, 1, 1, 5, 2, 5, 6, 2, 2, 6, 7, 2, 7, 3, 3, 7, 4, 3, 4, 0
    ]);

    private static const VERTICES:Vector.<Number> = Vector.<Number>([
        .5, .5, .5, -.5, .5, .5, -.5, .5, -.5, .5, .5, -.5,
        .5, -.5, .5, -.5, -.5, .5, -.5, -.5, -.5, .5, -.5, -.5
    ]);

    private var _numPoints:uint = 0;
    private var _vertices:Vector.<Number> = new Vector.<Number>();
    private var _indexStream:IndexStream;
    private var _vertexStream:VertexStream;


    public function PointsCloudGeometry(datas:Array) {
        var numPoints:int = (datas.length<NUM_POINTS_PER_MESH) ? datas.length : NUM_POINTS_PER_MESH;

        _indexStream = new IndexStream(StreamUsage.WRITE, null);

        _vertexStream=new VertexStream(StreamUsage.WRITE,VertexFormat.XYZ_RGB);

        for (var i:int = 0; i < numPoints; ++i) {
            addPoint(datas[i][0], datas[i][1], datas[i][2],datas[i][3]);
        }

        super(Vector.<IVertexStream>([_vertexStream]), _indexStream);

    }

    public function addPoint(lat:Number, lng:Number, size:Number, color:uint):void {
        var transform:Matrix4x4 = new Matrix4x4();
        var phi:Number = (90. - lat) * Math.PI / 180.;
        var theta:Number = (180. - lng) * Math.PI / 180.;
        var radius:int = 100;
        var verticesIterator:VertexIterator = new VertexIterator(_vertexStream, _indexStream);
        var data:Vector.<Number> = new Vector.<Number>();

        transform.appendScale(.35, .35, size || .1)
                .appendTranslation(radius * Math.sin(phi) * Math.cos(theta),
                radius * Math.cos(phi),
                -radius * Math.sin(phi) * Math.sin(theta)).lookAt(Vector4.ZERO);

        TMP_VERTICES.length = 0;
        transform.transformRawVectors(VERTICES, TMP_VERTICES);

        for (var i:int = 0; i < 8; ++i) {
            // fast but unclear
            data.push(TMP_VERTICES[int(i * 3)],
                    TMP_VERTICES[int(i * 3 + 1)],
                    TMP_VERTICES[int(i * 3 + 2)],
                    ((color >> 16) & 0xff) / 255.,
                    ((color >> 8) & 0xff) / 255.,
                    (color & 0xff) / 255.);

            // slow but convenient
            /* var vertex : VertexReference = new VertexReference(vertexStream);

             vertex.x = TMP_VERTICES[int(i * 3)];
             vertex.y = TMP_VERTICES[int(i * 3 + 1)];
             vertex.z = TMP_VERTICES[int(i * 3 + 2)];
             vertex.r = ((color >> 16) & 0xff) / 255.;
             vertex.g = ((color >> 8) & 0xff) / 255.;
             vertex.b = (color & 0xff) / 255.; */
        }

        _vertexStream.pushFloats(data);

        _indexStream.pushVector(INDICES, 0, 0, _numPoints * 8);

        ++_numPoints;
    }


}
}