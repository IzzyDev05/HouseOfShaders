#ifndef MYHLSLINCLUDE_INCLUDED
#define MYHLSLINCLUDE_INCLUDED

float mandelbrot(float2 uv, float iterations, float speed)
{
    float2 c = 4.0 * uv - float2(0.7, 0.0);
    c = c / speed - float2(0.65, 0.45);
    float2 z = float2(0.0,0.0);
    float iter = 0.0;

    for (float i=0.0; i < iterations; i++)
    {
        z = float2(z.x*z.x - z.y*z.y, 2.0 * z.x * z.y) + c;

        if (dot(z, z) > 4.0) return iter/iterations;
        iter++;
    }
    
    return 0.0;
}

void ReturnColor_float(float2 uv0, float iterations, float speed, float3 color1, float3 color2, out float4 Out)
{
    float3 col = float3(0.0, 0.0, 0.0);
    float m = mandelbrot(uv0, iterations, speed);;

    col += lerp(color1, color2, m);
    
    Out = float4(col, 1.0);
}

#endif