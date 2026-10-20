#version 460 core
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(location = 0) uniform vec2 u_resolution;
layout(location = 1) uniform float u_time;

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(0.02, 0.02, 0.04);
    float glow = sin(u_time + uv.x * 3.14159) * 0.5 + 0.5;
    color += vec3(0.54, 0.36, 0.96) * glow * 0.15;
    fragColor = vec4(color, 1.0);
}
