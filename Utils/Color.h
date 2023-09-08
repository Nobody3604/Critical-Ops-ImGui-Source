#ifndef Color_hpp
#define Color_hpp

#include <stdio.h>

typedef struct Color {
    int a, r, g, b;
    
    Color(int _r, int _g, int _b) : r(_r), g(_g), b(_b) {
        a = 255;
    }
    
    Color(int _r, int _g, int _b, int _a) : r(_r), g(_g), b(_b), a(_a) { }
    
 
    
    Color(float _r, float _g, float _b, float _a) : r(_r*255), g(_g*255), b(_b*255), a(_a*255) { }
    Color(int hex,int alpha)  {
        
        a = alpha;
        b = hex & 0x0000FF;
        hex = hex >> 8;
        g = hex & 0x0000FF;
        hex = hex >> 8;
        r = hex;
    }
    
     static Color Black;
        static Color White;
        static Color Red;
        static Color Green;
        static Color Blue;
        static Color Orange;
        static Color Yellow;
        static Color Gray;
        static Color Xue1;
        static Color Xue2;
        static Color Xue3;
        static Color Che;
        static Color Guge;
        static Color Quan;
        static Color Wuqi;
        static Color Yao;
        static Color Zhen;
        static Color Dui;
        static Color Ji;
        static Color renji;
    } Color;


#endif /* Color_hpp */
