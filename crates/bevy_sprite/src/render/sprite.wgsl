// Sexiest TODO: Modular sprite shaders
struct View {
    view_proj: mat4x4<f32>;
    world_position: vec3<f32>;
};
[[group(0), binding(0)]]
var<uniform> view: View;

struct VertexOutput {
    [[location(0)]] uv: vec2<f32>;
#ifdef COLORED
    [[location(1)]] color: vec4<f32>;
    [[location(2)]] bg_color: vec4<f32>;
#endif
    [[builtin(position)]] position: vec4<f32>;
};

[[stage(vertex)]]
fn vertex(
    [[location(0)]] vertex_position: vec3<f32>,
    [[location(1)]] vertex_uv: vec2<f32>,
#ifdef COLORED
<<<<<<< Updated upstream
    [[location(2)]] vertex_color: vec4<f32>,
=======
    [[location(2)]] vertex_color: vec2<u32>,
>>>>>>> Stashed changes
#endif
) -> VertexOutput {
    var out: VertexOutput;
    out.uv = vertex_uv;
    out.position = view.view_proj * vec4<f32>(vertex_position, 1.0);
#ifdef COLORED
<<<<<<< Updated upstream
    out.color = vertex_color;
=======
    out.color = vec4<f32>((vec4<u32>(vertex_color.x) >> vec4<u32>(0u, 8u, 16u, 24u)) & vec4<u32>(255u)) / 255.0;
    out.bg_color = vec4<f32>((vec4<u32>(vertex_color.y) >> vec4<u32>(0u, 8u, 16u, 24u)) & vec4<u32>(255u)) / 255.0;
>>>>>>> Stashed changes
#endif
    return out;
} 

[[group(1), binding(0)]]
var sprite_texture: texture_2d<f32>;
[[group(1), binding(1)]]
var sprite_sampler: sampler;

[[stage(fragment)]]
fn fragment(in: VertexOutput) -> [[location(0)]] vec4<f32> {
    var color = textureSample(sprite_texture, sprite_sampler, in.uv); 
#ifdef COLORED
    if (color.a == 0.0) {
        // TODO: Actual for real blending (sexy)
        // TODO: Have user specify a bg_color_target and replace it with bg_color
        color = in.bg_color;
    } else {
        // TODO: Actual for real blending (sexy)
        color = in.color * color;
    }
#endif
    return color;
}