#import "Drawst.h"
#import "Drawzb.h"
#import "Floating/JFCommon.h"
#import "Utils/Color.h"
#import "Macros.h"
#import "imgui/imgui/imgui.h"
#import "imgui/imgui/imgui_internal.h"
#import "imgui/GuiRenderer.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import <mach/mach.h>
#include <substrate.h>
#import "CoreText/CTFont.h"
#import "UTFMaster/utf.c"
#include <string>
#include <vector>
#include <map>
#import "Theme.h"


UIView* view;
UITextField *field = [[UITextField alloc] init];

static bool StreamerMode = false;
int tab = 0;



bool radar = false, CI = false, CS = false, spread = false, recoil = false, fov = false, aimassist = false, BDS = true, Firerate = false, rain = false, AimT = false, jumpforce = false, slow = false, blur = false, deploy = false, flashsmoke = false, aimpunch = false, tutorial = false, wallhack = false, thirdperson = false, crosshair = false, cRadius = false, cHeight = false, WI = false, dual = false, dryfire = false, ammo = false, melee = false, burstfire = false, CameraHeight = false, speed = false, damage = false, reload = false, armor = false, burst = false;

float fovS = 90.0f, FirerateV = 600.0f, forcejump = 4.099999904632568, cHeight1 = 1.4f, CameraHeight1 = 1.47f, speed1 = 5.0f, damage1 = 100.0f;

int rain1 = 0, aimType = 0, dual1 = 0, armor1 = 0;

const char *rain_items[2] = {"Body", "Head"};
const char *aim_items[3] = {"None", "Overlay", "ViewSpace"};
const char *dual_items[2] = {"Left", "Right"};
const char *armor_items[5] = {"Low", "Medium","High","VeryHigh","IgnoreArmor"};





void (*orig_Update)(void* this_, float deltatime);

void Update(void* this_, float deltatime) {

if (this_ != NULL) {

void* Data = *(void**)((uint64_t)this_ + 0xD8);

void* Wpn = *(void**)((uint64_t)Data + 0x80);

void* characterSettings = *(void**)((uint64_t)Data + 0x78);


if (Wpn) {

int ID = *(int*)((uint64_t)Wpn + 0x18);

int WeaponCategory = *(int*)((uint64_t)Wpn + 0x38);


if(WeaponCategory == 5){
if(melee){
*(float*)((uint64_t)Wpn + 0x60) = 100.0f;
}
}

if(burst){
*(int*)((uint64_t)Wpn + 0x68) = 90;
}

if(armor){
switch (armor1) {
case 0:
*(int*)((uint64_t)Wpn + 0x80) = 0;
break;
case 1:
*(int*)((uint64_t)Wpn + 0x80) = 1;
break;
case 2:
*(int*)((uint64_t)Wpn + 0x80) = 2;
break;
case 3:
*(int*)((uint64_t)Wpn + 0x80) = 3;
break;
case 4:
*(int*)((uint64_t)Wpn + 0x80) = 4;
break;
}
}

if(damage){
*(float*)((uint64_t)Wpn + 0x4C) = damage1;
*(float*)((uint64_t)Wpn + 0x50) = damage1;
}

if(reload){
*(float*)((uint64_t)Wpn + 0x84) = 0.0f;
}

if(burstfire){
*(int*)((uint64_t)Wpn + 0x11C) = 1.0f;
*(float*)((uint64_t)Wpn + 0x120) = 0.0f;
}

if(ammo){

*(bool*)((uint64_t)Wpn + 0x94) = false;

}

if(recoil){

*(float*)((uint64_t)Wpn + 0x100) = 0.0f;
*(float*)((uint64_t)Wpn + 0xF0) = 0.0f;

}

if (Firerate) {

*(float*)((uint64_t)Wpn + 0x64) = FirerateV;

switch(ID) {
case 17:
case 6525:
case 3078:
case 15079:
case 11:
*(float *)((uint64_t)Wpn + 0x8C) = 0.0f;
break;
}
}

if (AimT) {
switch (aimType) {
case 0:
*(int*)((uint64_t)Wpn + 0x98) = 0;
break;
case 1:
*(int*)((uint64_t)Wpn + 0x98) = 1;
break;
case 2:
*(int*)((uint64_t)Wpn + 0x98) = 2;
break;
}
}

if(deploy){
*(float*)((uint64_t)Wpn + 0x88) = 0.0f;
}

}
if(characterSettings){

if(speed){
*(float*)((uint64_t)characterSettings + 0x14) = speed1;
*(float*)((uint64_t)characterSettings + 0x18) = speed1;
*(float*)((uint64_t)characterSettings + 0x1C) = speed1;
*(float*)((uint64_t)characterSettings + 0x20) = speed1;
}

if(CameraHeight){
*(float*)((uint64_t)characterSettings + 0x44) = CameraHeight1;
}


if(jumpforce){
*(float*)((uint64_t)characterSettings + 0x4C) = forcejump;
*(float*)((uint64_t)characterSettings + 0x50) = forcejump;
}

if(slow){
*(float*)((uint64_t)characterSettings + 0x5C) = 0.0f;
*(float*)((uint64_t)characterSettings + 0x60) = 0.0f;
*(float*)((uint64_t)characterSettings + 0x64) = 0.0f;
}


}
}    
return orig_Update(this_, deltatime);
}

void (*orig_GetButton)(void* this_, int input);
void GetButton(void* this_, int input){

if(this_ != nullptr){

if(CS){
if(input == 5){
input = 7;
}
}


}
return orig_GetButton(this_, input);
}

void (*orig_Spread)(void* this_);
void Spread(void* this_){

if(spread){

return;

}

return orig_Spread(this_);
}

void (*orig_SHFOV)(void* this_, float hFov);
void SHFOV(void* this_, float hFov){

if(fov){

hFov = fovS;

}
return orig_SHFOV(this_, hFov);
}

Vector2 (*orig_CalculateAimAssist)(void* this_, void* localcharacter, float Amount, Vector2 turn, void* Config);

Vector2 CalculateAimAssist(void* this_, void* localcharacter, float Amount, Vector2 turn, void* Config){

if(aimassist){

Amount = 2.5f;

}

return orig_CalculateAimAssist(this_, localcharacter, Amount, turn, Config);
}

void (*orig_PMBGetButton)(void* this_, int input);
void PMBGetButton(void* this_, int input){

if(this_ != nullptr){

if(BDS){
if(input == 7){
input = 4;
}
}
}
return orig_PMBGetButton(this_, input);
}

void (*orig_OSpread)(void *this_, float value);

void OSpread(void *this_, float value){

if(this_ != NULL){

if(blur){
value = 0.0f;
}
}
return orig_OSpread(this_, value);
}


void (*orig_Aimpunch)(void* this_, float dt);
void Aimpunch(void* this_, float dt){

if(this_ != NULL){

if(aimpunch){

*(float *)((uint64_t)this_ + 0x58) = 0.0f;

*(float *)((uint64_t)this_ + 0x5C) = 0.0f;
return orig_Aimpunch(this_, 1000.0f);

}
}
return orig_Aimpunch(this_, dt);
}


void(*orig_ChangeState)(void *_this, int newState, bool targetState, void* followedCharacter);

void ChangeState(void *_this, int newState, bool targetState, void* followedCharacter){

if(_this != NULL){

if(thirdperson){

return orig_ChangeState(_this, 1, targetState, followedCharacter);

}
return orig_ChangeState(_this, newState, targetState, followedCharacter);
}
}


float(*orig_height)(void *_this);

float height(void *_this){

if(cHeight){

return cHeight1;

}

return orig_height(_this);
}


float(*orig_radius)(void *_this);

float radius(void *_this){

if(cRadius){

return -10.0f;

}

return orig_radius(_this);
}

void (*orig_ExplodeGrenade)(void* this_);
void ExplodeGrenade(void* this_){

if(this_ != NULL){

if(flashsmoke){

return;

}

}
return orig_ExplodeGrenade(this_);
}


void (*orig_CVFPUpdate)(void* this_, float deltaTime);
void CVFPUpdate(void* this_, float deltaTime){

if(this_ != NULL){

if(dual){
switch(dual1){
case 0:
*(bool*)((uint64_t)this_ + 0xF5) = true;
break;
case 1:
*(bool*)((uint64_t)this_ + 0xF5) = false;
break;
}
}

}
return orig_CVFPUpdate(this_, deltaTime);
}


void(*orig_MoveNext)(void *instance);
void MoveNext(void *instance){

if(instance != NULL){
    
if(dryfire){

*(float *) ((uint64_t)instance + 0x30) = -2.0f;

*(float *) ((uint64_t)instance + 0x40) = 0.0f;

}
}
return orig_MoveNext(instance);
}


void UpdateEnabledState(void* this_, int userID, int value){

if(this_ != NULL){

value = 0;

}
}

void (*og_HRUpdate)(void* obj);
void HRUpdate(void* obj){

if(obj != NULL){

if(CI){
*(bool*)((uint64_t)obj + 0x4C) = true;
*(bool*)((uint64_t)obj + 0x4D) = true;
*(bool*)((uint64_t)obj + 0x4E) = true;
}
}
return og_HRUpdate(obj);
}





@interface JFOverlayView () <GuiRendererDelegate> {
    ImFont *_espFont;
}

@property (nonatomic, strong) MTKView *mtkView;
@property (nonatomic, strong) GuiRenderer *renderer;

@end

@implementation JFOverlayView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        self.isShowMenu = false;

        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    [view setBackgroundColor:[UIColor clearColor]];
    [view setUserInteractionEnabled:YES];
    field.secureTextEntry = true;
    [view addSubview:field];
    view = field.layer.sublayers.firstObject.delegate;
    [[UIApplication sharedApplication].keyWindow addSubview:view];

    self.mtkView = [[MTKView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.mtkView.backgroundColor = [UIColor clearColor];
    [view addSubview:self.mtkView]; 
    self.mtkView.device = MTLCreateSystemDefaultDevice();
    if (!self.mtkView.device) {
        return;
    }
    self.renderer = [[GuiRenderer alloc] initWithView:self.mtkView];
    self.renderer.delegate = self;
    self.mtkView.delegate = self.renderer;
    [self.renderer initializePlatform];
}


- (void)setup
{
    ImGuiIO & io = ImGui::GetIO();
    ImFontConfig config;
    config.FontDataOwnedByAtlas = false;

    NSString *fontPath = @"/System/Library/Fonts/LanguageSupport/PingFang.ttc";
    _espFont = io.Fonts->AddFontFromFileTTF(fontPath.UTF8String, 20.f, &config, io.Fonts->GetGlyphRangesChineseFull());
    

}

- (void)draw
{
    [self drawOverlay];
    [self CheckStreamerMode];
    [self drawMenu];
    embraceTheDarkness();
    
     
}


- (void)drawMenu
{


    self.userInteractionEnabled = self.isShowMenu;
    self.mtkView.userInteractionEnabled = self.isShowMenu;
    if (!_isShowMenu) return;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat width = SCREEN_WIDTH * 0.6;
        CGFloat height = SCREEN_HEIGHT * 0.8;
        if (SCREEN_WIDTH > SCREEN_HEIGHT) {

            height = SCREEN_HEIGHT * 0.7;
        } else {

            width = SCREEN_WIDTH * 0.7;
        }
        ImGuiIO & io = ImGui::GetIO();
        io.DisplaySize = ImVec2(width, height);
        ImGui::SetNextWindowPos(ImVec2((SCREEN_WIDTH - width) * 0.7, (SCREEN_HEIGHT - height) * 0.5), 0, ImVec2(0, 0));
        ImGui::SetNextWindowSize(ImVec2(420, 280));
        io.FontGlobalScale = 0.85f;
    });
    
    
    ImGui::Begin("Critical Ops Cheats", &_isShowMenu, ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoResize);

ImGui::Columns(2);
ImGui::SetColumnOffset(1, 120);

ImGui::Spacing();
if(ImGui::Button("Main", ImVec2(100.0f, 40.0f))){
tab = 0;
}
ImGui::Spacing();
if(ImGui::Button("Offline", ImVec2(100.0f, 40.0f))){
tab = 1;
}

ImGui::Spacing();
ImGui::Spacing();
ImGui::Spacing();
ImGui::Spacing();
ImGui::Spacing();
ImGui::Spacing();
ImGui::Spacing();
ImGui::Spacing();
ImGui::Spacing();
ImGui::Spacing();
ImGui::Spacing();
ImGui::Spacing();
ImGui::Text("     Made By");
ImGui::Text("  EvilBunny420");

ImGui::NextColumn();
switch(tab){
case 0:
ImGui::BeginChild("##scroll1");
ImGui::Spacing();
ImGui::Spacing();
ImGui::Checkbox("Radar", &radar);
ImGui::Checkbox("CharacterIndicator", &CI);
ImGui::Checkbox("No Spread", &spread);
ImGui::Checkbox("No Recoil", &recoil);
ImGui::Checkbox("Rain", &rain);
if(rain){
ImGui::Combo("##rain", &rain1, rain_items, 2);
}
ImGui::Checkbox("Increased AimAssist", &aimassist);
ImGui::Checkbox("WeaponIndicator", &WI);
ImGui::Checkbox("No Flash/Smoke", &flashsmoke);
ImGui::Checkbox("Crouch Shoot", &CS);
ImGui::Checkbox("No Aimpunch", &aimpunch);
ImGui::Checkbox("Field Of View", &fov);
if(fov){
ImGui::SliderFloat("##FovSlider", &fovS, 25.0f, 165.0f, "FOV: %.3f");
}
ImGui::Checkbox("Firerate", &Firerate);
if(Firerate){
ImGui::SliderFloat("##Firerate", &FirerateV, 100.0f, 3500.0f, "Firerate: %.3f");
}
ImGui::Checkbox("AimType", &AimT);
if(AimT){
ImGui::Combo("##AimType", &aimType, aim_items, 3);
}
ImGui::Checkbox("Increased Jump Force", &jumpforce);
if(jumpforce){
ImGui::SliderFloat("##jump", &forcejump, 1.0f, 20.0f, "JumpForce: %.3f");
}
ImGui::Checkbox("No Slow Down", &slow);
ImGui::Checkbox("No Sniper Blur", &blur);
ImGui::Checkbox("No DeployTime", &deploy);
ImGui::Checkbox("Shoot Through Walls", &wallhack);
ImGui::Checkbox("Crosshair Always Visible", &crosshair);
ImGui::Checkbox("ThirdPerson View", &thirdperson);
ImGui::Checkbox("Walk Through Walls", &cRadius);
ImGui::Checkbox("Custom Height", &cHeight);
if(cHeight){
ImGui::SliderFloat("##height", &cHeight1, 1.0f, 10.0f, "Custom Height: %.3f");
}
ImGui::Checkbox("DualWield Fire", &dual);
if(dual){
ImGui::Combo("##dual", &dual1, dual_items, 2);
}
ImGui::Checkbox("Burst shoot only 1 bullet", &burstfire);
ImGui::Checkbox("Camera Height", &CameraHeight);
if(CameraHeight){
ImGui::SliderFloat("##1height", &CameraHeight1, -20.0f, 20.0f, "CameraHeight: %.3f");
}
ImGui::Checkbox("Tutorial Bypass", &tutorial);
ImGui::EndChild();
break;
case 1:
ImGui::BeginChild("##scroll2");
ImGui::Spacing();
ImGui::Spacing();
ImGui::Checkbox("Bots Dont Shoot", &BDS);
ImGui::Checkbox("No Dryfire", &dryfire);
ImGui::Checkbox("Unlimited Ammo", &ammo);
ImGui::Checkbox("Melee Range 100m", &melee);
ImGui::Checkbox("instant Reload", &reload);
ImGui::Checkbox("Custom Speed", &speed);
if(speed){
ImGui::SliderFloat("##speed", &speed1, 1.0f, 50.0f, "Custom Speed: %.3f");
}
ImGui::Checkbox("Custom Damage", &damage);
if(damage){
ImGui::SliderFloat("##damage", &damage1, 1.0f, 200.0f, "Custom Damage: %.3f");
}
ImGui::Checkbox("ArmorPenetration", &armor);
if(armor){
ImGui::Combo("##armorP", &armor1, armor_items, 5);
}
ImGui::Checkbox("Burst", &burst);
ImGui::EndChild();
break;
}

ImGui::End();


timer(5){

if(radar){
patchOffset(0x1583BB8, 0xC8008052);
} else {
patchOffset(0x1583BB8, 0xC8098052);
}

if(CI){
patchOffset(0x152FEA0, 0x200080D2);
patchOffset(0x153158c, 0x200080D2C0035FD6);
patchOffset(0x1531714, 0x200080D2C0035FD6);
} else {
patchOffset(0x152FEA0, 0x1F050031);
patchOffset(0x153158c, 0xFF0302D1EF3B016D);
patchOffset(0x1531714, 0xFFC303D1EF3B066D);
}

if (rain) {
switch (rain1) {
case 0:
patchOffset(0x1488788, 0x0090261E);
patchOffset(0x14887D4, 0x18150071);
break;
case 1:
patchOffset(0x1488788, 0x0090261E);
patchOffset(0x14887D4, 0x18050071);
break;
}
} else {
patchOffset(0x1488788, 0xE003271E);
patchOffset(0x14887D4, 0x18050071);
}

if(tutorial){
patchOffset(0x179B1D0, 0x60018052C0035FD6);
patchOffset(0x179BB14, 0x60018052C0035FD6);
patchOffset(0x179AFB8, 0x60018052C0035FD6);
patchOffset(0x179AB78, 0x60018052C0035FD6);
patchOffset(0x179B3E8, 0x60018052C0035FD6);
} else {
patchOffset(0x179B1D0, 0xA0058052C0035FD6);
patchOffset(0x179BB14, 0xA0058052C0035FD6);
patchOffset(0x179AFB8, 0xA0058052C0035FD6);
patchOffset(0x179AB78, 0xA0058052C0035FD6);
patchOffset(0x179B3E8, 0xA0058052C0035FD6);
}

if(wallhack){
patchOffset(0x148d61c, 0xC0035FD6);
patchOffset(0x1490E3C, 0x08E28452);
} else {
patchOffset(0x148d61c, 0xFF4301D1);
patchOffset(0x1490E3C, 0x880C8052);
}

if(crosshair){
patchOffset(0x1618b7c, 0x200080D2);
} else {
patchOffset(0x1618b7c, 0x00604239);
}

if(WI){
patchOffset(0x1764690, 0x20008052C0035FD6);
} else {
patchOffset(0x1764690, 0xFF8301D1F44F04A9);
}

});


}

- (void)CheckStreamerMode{
    if(StreamerMode){
        [IFuckYou getNoRecView].secureTextEntry = true;
        field.secureTextEntry = true;
    }
    else{
        [IFuckYou getNoRecView].secureTextEntry = false;
        field.secureTextEntry = false;
    }
    return;
}
- (void)drawOverlay 
{
    return;   
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.renderer handleEvent:event view:self];
}

@end


%ctor{
timer(5){

HOOK_NO_ORIG(0x139AAFC, UpdateEnabledState);

HOOK(0x13ebc0c, OSpread, orig_OSpread);

HOOK(0x1583b10, Update, orig_Update);

HOOK(0x17ADD60, GetButton, orig_GetButton);

HOOK(0x16848E4, PMBGetButton, orig_PMBGetButton);

HOOK(0x144bb80, Spread, orig_Spread);

HOOK(0x16f5488, SHFOV, orig_SHFOV);

HOOK(0x160e480, CalculateAimAssist, orig_CalculateAimAssist);

HOOK(0x144cc38, Aimpunch, orig_Aimpunch);

HOOK(0x16f4180, ChangeState, orig_ChangeState);

HOOK(0x16be8dc, ExplodeGrenade, orig_ExplodeGrenade);

HOOK(0x285C9F0, radius, orig_radius);

HOOK(0x285CA40, height, orig_height);

HOOK(0x1739be0, CVFPUpdate, orig_CVFPUpdate);

HOOK(0x15bded4, MoveNext, orig_MoveNext);

HOOK(0x1532490, HRUpdate, og_HRUpdate);

});
}