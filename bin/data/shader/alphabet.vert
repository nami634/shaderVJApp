
#version 150

#define PI 3.141592653589793
#define PI_2 6.283185307179586
#define SQRT_2 1.4142135623730951
#define H_SQRT_2 0.7071067811865476
#define SQRT_3 0.8660254037844386

#define L_SIZE 200.
#define SPAN 20.
#define L_SIZE_SPAN L_SIZE/2.+SPAN

#define L_NUM 250000.
#define V_L_NUM 0.000004


uniform mat4 modelViewProjectionMatrix;

in vec4 position;

in vec4 normal;
uniform float time;
uniform int vertex_num;
uniform vec4 seed0;
out vec4 v_color;

float rnd(vec2 n){
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}
vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}


float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                    dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
               mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                   dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

vec3 A(float a){return vec3((vec2(a*1.25-.5,((mod(a*1.25,.5)-.25)*2.)*-sign(step(.4,a)-.1))*step(-.7999,-a)+vec2((a-.8)*2.5-.25,.0)*step(.8,a))*vec2(.8,1.),0.);}
vec3 B(float a){return vec3(vec2(max(cos(PI_2*a),-.5)*.75-.25,sin(PI_2*a)/max(step(0.,cos(PI_2*a)),max(abs(sin(PI_2*a)),SQRT_3))*(1.-step(-.5,cos(PI_2*a))*.5)+.5*step(-.5,cos(PI_2*a))*sign(mod(a,.001)-.00051))*.5,0.);}
vec3 C(float a){return vec3(cos((.25+a*1.5)*PI),sin((.25+a*1.5)*PI),0.)*.5;}
vec3 D(float a){return vec3(vec2(max(cos(PI_2*a),-.5)-.25,sin(PI_2*a)/max(step(0.,cos(PI_2*a)),max(abs(sin(PI_2*a)),SQRT_3)))*.5,0.);}
vec3 E(float a){return vec3(vec2(max(3.6*mod(a,.33333),.6)-.9,min(-0.5+floor(a*3.)+step(-0.166666,-mod(a,.333333)),max((mod(a,.333333)*3.-.5)*sign(-a+.33333), -1.+.5*(floor(3.*a-.000001)+1.)*step(.166666,mod(a,.333333))))),.0);}
vec3 F(float a){return vec3(vec2(max(2.2*mod(a,.50001),.6)-.8,max((mod(a,.50001)*2.-.5)*sign(a-.50001), -.5+.5*(floor(2.*a-.00001)+1.)*step(.25,mod(a,.50001)))),.0);}
vec3 G(float a){return vec3(vec2(cos((.27+(a*1.25)*1.5)*PI),sin((.27+(a*1.25)*1.5)*PI))*step(-.8,-a)+vec2(cos(H_SQRT_2),-(a-.8)*10.*sin(H_SQRT_2))*step(-.9,-a)*step(.80001,a)+vec2((a-.9)*cos(H_SQRT_2)*10.,0.)*step(.9,a),0.)*.5;}
vec3 H(float a){return vec3(vec2(step(.4,a)*.6-.3,mod(a,.4)*2.5-.5)*step(-.80001,-a-.0001)+vec2((a-.8)*3.-.3,.0)*step(.8,a),.0);}
vec3 I(float a){return vec3(0.,a-.5,0.);}
vec3 J(float a){return vec3(vec2(max(cos(PI_2*a),step(.0,sin(PI_2*a))*2.-1.)*.6,sin(PI_2*a)*(1.+2.*step(.0,sin(PI_2*a)))*.5-.5)*.5,0.);}
vec3 K(float a){return vec3(vec2(max(2.4*mod(a,.50001),.6)-.9,(mod(a,.50001)*2.-.5)*sign(a-.50001)),.0);}
vec3 L(float a){return vec3(vec2(-.3,a*2.-.5)*step(-.5,-a)+vec2((a-.5)*1.2-.3,-.5)*step(.500001,a),.0);}
vec3 M(float a){return vec3((a-.5)*.9,-(mod(a,.25)-.125)*4./(1.+step(-.24999,-abs(a-.5)))*-sign(step(-.24999999,-mod(a,.5))-.1)+.25*step(-.24999,-abs(a-.5)),.0);}
vec3 N(float a){return vec3(vec2(sign(a*2.-1.)*min(abs(a*1.8-.9),.3),-mod(a,.33333333)*3.+.5),.0);}
vec3 O(float a){return vec3(cos(a*PI_2)*.45,sin(a*PI_2)*.5,.0);}
vec3 P(float a){return vec3(vec2(max(cos(PI_2*a),-.5)*.75-.25,sin(PI_2*a)/max(step(0.,cos(PI_2*a)),max(abs(sin(PI_2*a)),SQRT_3))*(1.-step(-.5,cos(PI_2*a))*.5)+.5*step(-.5,cos(PI_2*a)))*.5,0.);}
vec3 Q(float a){return vec3(vec2(cos(a*PI_2*1.25)*.45,sin(a*PI_2*1.25)*.5)*step(-0.8001,-a)+vec2(a-.6, -(a-.5))*step(0.8001,a),.0);}
vec3 R(float a){return vec3(vec2(max(cos(PI_2*a),-.5)*.75-.25+4*(mod(a,.5)+.1)*step(.5,a)*step(-.66666666,-a)*step(.0,mod(a,.001)-.00051),sin(PI_2*a)/max(step(0.,cos(PI_2*a)),max(abs(sin(PI_2*a)),SQRT_3))*(1.-step(-.5,cos(PI_2*a))*.5)+.5*step(-.5,cos(PI_2*a)))*.5,0.);}
vec3 S(float a){return vec3((vec2(cos((a*2.)*PI_2),(abs(sin((a*2.)*PI_2))+1.)*sign(a-.250001))*step(-.5,-a)+vec2(cos(a*PI_2),(sin(a*PI_2)+1.) * sign(a-.75))*step(.5000001,a))*vec2(.3,-.25),.0);}
vec3 T(float a){return vec3(vec2(0.,a*2.-.5)*step(-.5,-a)+vec2((a-.5)*1.6-.4,.5)*step(.500001,a),.0);}
vec3 U(float a){return vec3(vec2(max(cos(PI_2*a), step(.001,sin(PI_2*a))*2.-1.)*sign(.00001+cos(PI_2*a)+step(.001,-sin(PI_2*a)))*.6,sin(PI_2*a)*(1.+2.*step(.0,sin(PI_2*a)))*.5-.5)*.5,0.);}
vec3 V(float a){return vec3((a-.5)*.8,((mod(a,.50001)-.25)*2)*sign(step(.50001,a)-.1),0.);}
vec3 W(float a){return vec3((a-.5)*.9,(mod(a,.25)-.125)*4./(1.+step(-.24999,-abs(a-.5)))*-sign(step(-.24999999,-mod(a,.5))-.1)-.25*step(-.24999,-abs(a-.5)),.0);}
vec3 X(float a){return vec3(vec2(1.2*mod(a,.50001)-.3,(mod(a,.50001)*2.-.5)*sign(a-.50001)),.0);}
vec3 Y(float a){return vec3(vec2((1.2*mod(a,.50001)-.3)*sign(a-.50001)*step(.25,mod(a,.50001)),(mod(a,.50001)*2.-.5)),.0);}
vec3 Z(float a){return vec3(vec2(mod(a,.33333333)*2.4-.4,sign(a*2.-1.)*min(abs(a*3.-1.5),.5)),.0);}


void main(){

    vec3 pos = vec3(.0,.0,100000.);
    if (gl_VertexID <= L_NUM) {
        pos = Z(gl_VertexID * V_L_NUM)*L_SIZE+vec3(-(L_SIZE_SPAN)*3.,.0,.0);
    } else if(gl_VertexID <= L_NUM *2.) {
        pos = A((gl_VertexID - L_NUM) * V_L_NUM) * L_SIZE+vec3(-(L_SIZE_SPAN),.0,.0);
    } else if(gl_VertexID <= L_NUM* 3.) {
        pos = W((gl_VertexID - L_NUM * 2.) * V_L_NUM) * L_SIZE+vec3(L_SIZE_SPAN,.0,.0);
    } else if(gl_VertexID <= L_NUM*4.) {
        pos = I((gl_VertexID - L_NUM*3.) * V_L_NUM) * L_SIZE+vec3((L_SIZE_SPAN)*3.,.0,.0);
    }

   // pos *= sin(time + gl_VertexID * 0.000002);

   gl_PointSize = 1.0;

    gl_Position = modelViewProjectionMatrix * vec4(pos,1.0);
    // v_color = vec4(0.3, noise(vec2(gl_VertexID/ vertex_num * seed0.x, time * seed0.y)), 1.0, 1.0);
    v_color = vec4(1.0);
}
