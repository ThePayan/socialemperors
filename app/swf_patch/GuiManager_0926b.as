package GUI
{
   import caurina.transitions.*;
   import com.socialpoint.debug.*;
   import com.socialpoint.social.cross.CrossManager;
   import core.*;
   import core.isoengine.*;
   import core.statics.*;
   import expansion.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.ExternalInterface;
   import flash.geom.*;
   import flash.text.*;
   import flash.ui.Keyboard;
   import flash.utils.*;
   import managers.*;
   import managers.offers.KompuManager;
   import newTowns.*;
   import popups.*;
   import quest.*;
   import utils.TextFieldUtil;
   
   public class GuiManager extends GuiMC
   {
      
      private var txtFilter:TextField;
      
      private var filterTimer:Timer;
      
      private var tooltip:TooltipSimbolosAtaqueMC;
      
      public var _viralButtonPanel:IconPanel;
      
      private var bOptionsHidden:Boolean = true;
      
      public var tTimer:Timer;
      
      public var bookmarkButton:* = null;
      
      private var etcNames:Array;
      
      private var coinTextStartPos:Point;
      
      private var fullscreenYShift:int = 0;
      
      private var leftElements:Array;
      
      private var zoomSpeed:Number = 2;
      
      private var rightElements:Array;
      
      private var startX:int;
      
      private var startY:int;
      
      private var testString:String = "";
      
      private var currentMenuInd:int = 0;
      
      private var currentWindowInd:int = 0;
      
      private var topElements:Array;
      
      private var currentMenu:*;
      
      private var zoomState:int = 0;
      
      private var buttons:Array;
      
      private var fullscreenXShift:int = 0;
      
      private var zoomSlider:ZoomSlider;
      
      public var tabs:Array;
      
      public var audioSprites:AudioSheet;
      
      public var countdownTimer:CountdownTimer;
      
      public var countdownTimerOgres:CountdownTimer;
      
      public var countdownAssault:CountdownTimer;
      
      private var buttonCover:* = null;
      
      private var tabNames:Array;
      
      private var dollarTextStartPos:Point;
      
      private var currentWindow:*;
      
      private var toolTip:* = null;
      
      private var testInc:int = 0;
      
      private var topNames:Array;
      
      private var experienceBarStartPos:Point;
      
      private var recolectaRapidoStartX:int;
      
      private var recolectaRapidoStartY:int;
      
      private var playerInfo:Object;
      
      public var sfxOn:Boolean = true;
      
      public var musicOn:Boolean = true;
      
      public var friendsWindow:*;
      
      public var storeWindow:*;
      
      public var numTabsStore:int = 8;
      
      public var likeButton:* = null;
      
      public var missionBox:MovieClip;
      
      public var magicBox:MovieClip;
      
      private var viralNeighborButton:GuiInviteButton;
      
      private var viralGiftsButton:GuiGiftButton;
      
      private var dailyButton:MovieClip;
      
      private var mondayBonusButton:MondayBonusButton;
      
      private var mobileGiftsButton:MobileGuiGiftButton;
      
      private var iconVideo:IconVideoMC;
      
      private var iconComeBack2nd3rd:IconComeBack2nd3rdMC;
      
      private var menVsWomenButton:MovieClip;
      
      private var dragonCityBtn:dragonCityMC;
      
      private var askPermission:MovieClip;
      
      private var offerButton:MovieClip;
      
      public var recuadroShowed:Boolean;
      
      public var fondoBotonDollar:GuiButton;
      
      public var expolorationWorld:ExplorationsManager;
      
      public var recuadroInfo:RecuadroInfo;
      
      public var tTimerOptions:Timer;
      
      public var missionOffset:int = 0;
      
      public var iconGods:IconGodsMC;
      
      public var filter:String = "";
      
      public function GuiManager(param1:*, param2:int = 0, param3:int = 0, param4:Object = null)
      {
         Base.Player.addEventListener(PlayerStatus.EVT_LEVEL_UP,this.onLevelUp);
         this.tabs = new Array(0);
         this.buttons = new Array(0);
         this.audioSprites = new AudioSheet(0,0);
         this.tabNames = new Array(Language.getLiteral(Language.MENU_VECINOS),Language.getLiteral(Language.MENU_CASAS),Language.getLiteral(Language.MENU_DECORACIONES),Language.getLiteral(Language.MENU_DEFENSAS),Language.getLiteral(Language.MENU_EJERCITO),Language.getLiteral(Language.MENU_EXPANSION),Language.getLiteral(Language.MENU_REGALOS),Language.getLiteral(Language.MENU_MARAVILLAS));
         this.topNames = new Array(Language.getLiteral(Language.TOOLTIP_ORO),Language.getLiteral(Language.TOOLTIP_CASH),Language.getLiteral(Language.TOOLTIP_TROFEOS),Language.getLiteral(Language.TOOLTIP_FALTA_POCO),Language.getLiteral(Language.TOOLTIP_MUSICA),Language.getLiteral(Language.TOOLTIP_EFECTOS_SONIDO),Language.getLiteral(Language.TOOLTIP_FOTOS),Language.getLiteral(Language.TOOLTIP_PANTALLA_COMPLETA),Language.getLiteral(Language.TOOLTIP_CALIDAD),Language.getLiteral(Language.TOOLTIP_VOLVER),Language.getLiteral(Language.TOOLTIP_TE_GUSTA));
         this.etcNames = new Array(Language.getLiteral(Language.TOOLTIP_MULTI),Language.getLiteral(Language.TOOLTIP_ELIMINAR),Language.getLiteral(Language.TOOLTIP_INVITACIONES_AMIGOS),Language.getLiteral(Language.TOOLTIP_REGALOS),Language.getLiteral(Language.TOOLTIP_RECOLECTAR),Language.getLiteral(Language.TOOLTIP_TIENDA));
         this.topElements = [];
         this.leftElements = [];
         this.rightElements = [];
         super();
         Base.Main = param1;
         Base.Main.getStage().addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullscreenChange);
         Base.Main.getStage().addEventListener(MouseEvent.MOUSE_OVER,this.rufflefixHoverCheck,true);
         Base.Main.getStage().addEventListener(MouseEvent.MOUSE_MOVE,this.rufflefixHoverCheck,true);
         Base.Main.addEventListener(Event.ADDED,this.rufflefixSelectorAdded);
         this.playerInfo = param4;
         this.startX = param2;
         this.startY = param3;
         this.panelCollection.visible = false;
         x = param2;
         y = param3;
         this.recuadroInfo = new RecuadroInfo(this.bgBar.recuadroInfo);
      }
      
      public function init() : void
      {
         var _loc4_:* = undefined;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         this.createButtonsHerramientas();
         this.friendsWindow = this.bgBar.mcFriends.addChild(new FriendsWindow(Base.Main,this,-10,-12));
         this.addCashButton.addEventListener(MouseEvent.MOUSE_DOWN,this.addCashButtonClick);
         this.addCashButton.addEventListener(MouseEvent.ROLL_OVER,this.showAddCashToolTip);
         this.addCashButton.addEventListener(MouseEvent.ROLL_OUT,this.hideToolTip);
         this.topElements.push(this.addCashButton);
         this.addCashButton.buttonMode = true;
         var _loc5_:* = this.addChild(new GuiButton(Base.Main,this,5 + 250,-520 + 25,0));
         this.buttons.push(_loc5_);
         this.topElements.push(_loc5_);
         this.setChildIndex(_loc5_,0);
         _loc5_.visible = false;
         this.fondoBotonDollar = this.addChild(new GuiButton(Base.Main,this,136 + 250,-521 + 25 + 20,1)) as GuiButton;
         this.buttons.push(this.fondoBotonDollar);
         this.topElements.push(this.fondoBotonDollar);
         this.setChildIndex(this.fondoBotonDollar,0);
         this.topElements.push(this.coinText);
         this.coinTextStartPos = new Point(this.coinText.x,this.coinText.y);
         this.dollarText.mouseEnabled = false;
         this.topElements.push(this.dollarText);
         this.dollarTextStartPos = new Point(this.dollarText.x,this.dollarText.y);
         this.options_panel.bm.visible = Base.Main.settings.data.music != 0;
         this.options_panel.bm.addEventListener(MouseEvent.CLICK,this.toggleMusic);
         this.options_panel.bmo.visible = Base.Main.settings.data.music == 0;
         this.options_panel.bmo.addEventListener(MouseEvent.CLICK,this.toggleMusic);
         this.options_panel.bs.visible = Base.Main.settings.data.sfx != 0;
         this.options_panel.bs.addEventListener(MouseEvent.CLICK,this.toggleSound);
         this.options_panel.bso.visible = Base.Main.settings.data.sfx == 0;
         this.options_panel.bso.addEventListener(MouseEvent.CLICK,this.toggleSound);
         this.options_panel.bf.visible = true;
         this.options_panel.bf.addEventListener(MouseEvent.CLICK,this.toggleFullscreen);
         this.options_panel.bfo.visible = false;
         this.options_panel.bfo.addEventListener(MouseEvent.CLICK,this.toggleFullscreen);
         this.options_panel.bp.visible = true;
         this.options_panel.bp.addEventListener(MouseEvent.CLICK,this.togglePause);
         this.options_panel.y -= 15;
         this.options_panel.bo.addEventListener(MouseEvent.CLICK,this.onClickOptions);
         this.tTimerOptions = new Timer(5000,0);
         this.tTimerOptions.addEventListener(TimerEvent.TIMER,this.onRollOptions);
         this.createViralButtons();
         this.topElements.push(this.experienceBar);
         this.experienceBarStartPos = new Point(this.experienceBar.x,this.experienceBar.y);
         this.musicOn = Boolean(Base.Main.settings.data.music);
         this.zoomSlider = new ZoomSlider(Base.Main,this,742,-190);
         this.addChildAt(this.zoomSlider,getChildIndex(this.bgBar) - 1);
         this.rightElements.push(this.zoomSlider);
         if(Base.Main.gameMode != Constants.GAME_MODE_NORMAL)
         {
            this.bgBar.returnHome.visible = true;
         }
         else
         {
            this.bgBar.returnHome.visible = false;
         }
         this.leftElements.push(this.bgBar.returnHome);
         this.bgBar.returnHome.buttonMode = true;
         this.bgBar.returnHome.addEventListener(MouseEvent.MOUSE_DOWN,this.returnToMap);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         _loc4_ = this.addChild(new Sprite());
         this.createStore();
         this.setPlayerInfo();
         this.bgBar.recuadroInfo.y = 123;
         this.recuadroShowed = true;
         this.hideRecuadro();
         this.experienceBar.btnWorld.addEventListener(MouseEvent.CLICK,this.showWorld);
         this.barraAttackArriba.visible = false;
         this.experienceBar.btnWorld.addEventListener(MouseEvent.ROLL_OVER,this.showMapToolTip);
         this.experienceBar.btnWorld.addEventListener(MouseEvent.ROLL_OUT,this.hideToolTip);
         questProgressButton.addEventListener(MouseEvent.CLICK,this.openQuestProgressPopup);
         questProgressButton.visible = false;
         this.bgBar.mcTrolls.buf.visible = false;
         this.bgBar.mcTrolls.cara.visible = false;
         this.bgBar.mcTrolls.cara.addEventListener(MouseEvent.MOUSE_OVER,this.onOverFace);
         this.bgBar.mcTrolls.cara.addEventListener(MouseEvent.MOUSE_OUT,this.onOutFace);
      }
      
      public function onOverFace(param1:Event = null) : void
      {
         this.bgBar.mcTrolls.buf.visible = true;
      }
      
      public function onOutFace(param1:Event = null) : void
      {
         this.bgBar.mcTrolls.buf.visible = false;
      }
      
      public function onClickOptions(param1:Event = null) : void
      {
         if(this.bOptionsHidden)
         {
            this.onUnrollOptions();
         }
         else
         {
            this.onRollOptions();
         }
      }
      
      public function togglePause(param1:Event = null) : void
      {
         Base.Main.pauseGame(true,true);
      }
      
      public function onUnrollOptions(param1:Event = null) : void
      {
         this.bOptionsHidden = false;
         this.tTimerOptions.stop();
         this.tTimerOptions.reset();
         this.tTimerOptions.start();
         Tweener.addTween(this.options_panel,{
            "x":760 + (Base.Main.getStage().stageWidth - 760) / 2 - 90,
            "time":0.5,
            "transition":"easeOutExpo"
         });
      }
      
      public function onRollOptions(param1:Event = null) : void
      {
         this.bOptionsHidden = true;
         this.tTimerOptions.stop();
         this.tTimerOptions.reset();
         Tweener.addTween(this.options_panel,{
            "x":760 + (Base.Main.getStage().stageWidth - 760) / 2 - 30,
            "time":0.5,
            "transition":"easeOutExpo"
         });
      }
      
      public function createButtonsHerramientas() : void
      {
         this.bgBar.storeButton.buttonMode = true;
         this.bgBar.storeButton.addEventListener(MouseEvent.MOUSE_DOWN,this.storeButtMouse1);
         this.bgBar.giftButton.buttonMode = true;
         this.bgBar.giftButton.addEventListener(MouseEvent.MOUSE_DOWN,this.openGiftMenu);
         this.bgBar.giftCounter.mouseChildren = false;
         this.bgBar.giftCounter.mouseEnabled = false;
         this.bgBar.giftCounter.visible = Base.Main.gifts.length > 0;
         TextFieldUtil.setHTML(this.bgBar.giftCounter.count,String(Base.Main.gifts.length));
         this.bgBar.giftCounter.count.antiAliasType = "advanced";
         this.bgBar.recolectaRapido.buttonMode = true;
         this.bgBar.recolectaRapido.addEventListener(MouseEvent.CLICK,this.dongleButtMouse1);
         this.bgBar.recolectaRapidoStartX = this.bgBar.recolectaRapido.x;
         this.bgBar.recolectaRapidoStartY = this.bgBar.recolectaRapido.y;
         this.bgBar.normalMouse.buttonMode = true;
         this.bgBar.normalMouse.addEventListener(MouseEvent.CLICK,this.openMouseMenu);
         this.bgBar.normalMouse.n = 0;
         this.bgBar.bulldozer.buttonMode = true;
         this.bgBar.bulldozer.addEventListener(MouseEvent.CLICK,this.bulldozeMouse);
         this.bgBar.bulldozer.n = 1;
         this.bgBar.gamesButton.buttonMode = true;
         this.bgBar.gamesButton.addEventListener(MouseEvent.MOUSE_DOWN,this.openGamesMenu);
         this.bgBar.herramientaCuadrado.buttonMode = true;
         this.bgBar.herramientaCuadrado.addEventListener(MouseEvent.MOUSE_OVER,this.onHerramientaCuadradoFrameOver);
         this.bgBar.herramientaCuadrado.addEventListener(MouseEvent.MOUSE_OUT,this.onHerramientaCuadradoFrameOut);
         this.bgBar.herramientaCuadrado.addEventListener(MouseEvent.CLICK,this.activarHerramientaCuadrado);
         TextFieldUtil.setHTML(this.bgBar.herramientaCuadrado.cuadradoText,Language.getLiteral(Language.ICON_SQUARE_TOOL));
         this.bgBar.achievementsButton.buttonMode = true;
         this.bgBar.achievementsButton.addEventListener(MouseEvent.MOUSE_DOWN,this.openWorldMenu);
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenu.normalMouse.addEventListener(MouseEvent.CLICK,this.iconMenuMouse);
         this.bgBar.iconMenu.bulldozer.addEventListener(MouseEvent.CLICK,this.iconMenuBulldoze);
         this.bgBar.iconMenu.recolectaRapido.addEventListener(MouseEvent.CLICK,this.iconMenuCollect);
         TextFieldUtil.setHTML(this.bgBar.iconMenu.normalMouseText,Language.getLiteral(Language.ICON_MENU_MULTI_TOOL));
         TextFieldUtil.setHTML(this.bgBar.iconMenu.bulldozerText,Language.getLiteral(Language.ICON_MENU_REMOVE));
         TextFieldUtil.setHTML(this.bgBar.iconMenu.recolectaRapidoText,Language.getLiteral(Language.ICON_MENU_FAST_COLLECT));
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuGift.colButton.addEventListener(MouseEvent.CLICK,this.collectionButton);
         this.bgBar.iconMenuGift.giftButton.addEventListener(MouseEvent.CLICK,this.giftButtMouse1);
         this.bgBar.iconMenuGift.newsButton.addEventListener(MouseEvent.CLICK,Base.PopUp.openPopupNews);
         this.bgBar.iconMenuGift.unitsButton.addEventListener(MouseEvent.CLICK,Base.PopUp.openUnitsList);
         TextFieldUtil.setHTML(this.bgBar.iconMenuGift.giftsText,Language.getLiteral(Language.ICON_MENU_GIFT_GIFTS));
         TextFieldUtil.setHTML(this.bgBar.iconMenuGift.newsText,Language.getLiteral(Language.ICON_MENU_GIFT_NEWS));
         TextFieldUtil.setHTML(this.bgBar.iconMenuGift.unitsText,Language.getLiteral(Language.ICON_MENU_GIFT_UNITS));
         TextFieldUtil.setHTML(this.bgBar.iconMenuGift.colText,Language.getLiteral(Language.ICON_MENU_GIFT_COLLECTIONS));
         this.bgBar.iconMenuWorld.visible = false;
         this.bgBar.iconMenuWorld.pvpButton.addEventListener(MouseEvent.CLICK,this.achievementsButtonClick);
         this.bgBar.iconMenuWorld.questButton.addEventListener(MouseEvent.CLICK,this.goQuests);
         this.bgBar.iconMenuWorld.survivalButton.addEventListener(MouseEvent.CLICK,this.openPopupSurvival);
         this.bgBar.iconMenuWorld.tournamentButton.addEventListener(MouseEvent.CLICK,this.openPopupTournament);
         this.bgBar.iconMenuWorld.pvpButton.addEventListener(MouseEvent.MOUSE_OVER,this.showTooltipWorld);
         this.bgBar.iconMenuWorld.pvpButton.addEventListener(MouseEvent.MOUSE_OUT,this.removeTooltipWorld);
         this.bgBar.iconMenuWorld.questButton.addEventListener(MouseEvent.MOUSE_OVER,this.showTooltipWorld);
         this.bgBar.iconMenuWorld.questButton.addEventListener(MouseEvent.MOUSE_OUT,this.removeTooltipWorld);
         this.bgBar.iconMenuWorld.survivalButton.addEventListener(MouseEvent.MOUSE_OVER,this.showTooltipWorld);
         this.bgBar.iconMenuWorld.survivalButton.addEventListener(MouseEvent.MOUSE_OUT,this.removeTooltipWorld);
         this.bgBar.iconMenuWorld.tournamentButton.addEventListener(MouseEvent.MOUSE_OVER,this.showTooltipWorld);
         this.bgBar.iconMenuWorld.tournamentButton.addEventListener(MouseEvent.MOUSE_OUT,this.removeTooltipWorld);
         TextFieldUtil.setHTML(this.bgBar.iconMenuWorld.questText,Language.getLiteral(Language.ICON_MENU_WORLD_QUEST));
         TextFieldUtil.setHTML(this.bgBar.iconMenuWorld.survivalText,Language.getLiteral(Language.ICON_MENU_WORLD_SURVIVAL));
         TextFieldUtil.setHTML(this.bgBar.iconMenuWorld.tournamentText,Language.getLiteral(Language.ICON_MENU_WORLD_TOURNEY));
         this.bgBar.iconMenuGames.visible = false;
         this.bgBar.iconMenuGames.herramientaDarts.addEventListener(MouseEvent.CLICK,this.abrirDarts);
         this.bgBar.iconMenuGames.herramientaSelectorMundo.addEventListener(MouseEvent.CLICK,this.abrirSelectorMundo);
         TextFieldUtil.setHTML(this.bgBar.iconMenuGames.dartsText,Language.getLiteral(Language.ICON_MENU_GAME_DARTS));
         if(Base.Player.iLevel < Config.TROL_RACE_MIN_LEVEL && Base.Player.currentRace == Constants.FACTION_HUMAN)
         {
            this.bgBar.iconMenuGames.herramientaSelectorMundo.visible = false;
            this.bgBar.iconMenuGames.txtSelectorMundo.visible = false;
         }
      }
      
      protected function onHerramientaCuadradoFrameOut(param1:MouseEvent) : void
      {
         this.bgBar.herramientaCuadrado.gotoAndStop(1);
      }
      
      protected function onHerramientaCuadradoFrameOver(param1:MouseEvent) : void
      {
         this.bgBar.herramientaCuadrado.gotoAndStop(2);
         TextFieldUtil.setHTML(param1.currentTarget.spaceKeyText,Language.getLiteral(Language.TEXT_SPACE_KEY));
      }
      
      public function showTooltipWorld(param1:Event) : void
      {
         if(this.tooltip != null)
         {
            this.bgBar.iconMenuWorld.removeChild(this.tooltip);
            this.tooltip = null;
         }
         if(param1.currentTarget.name == "pvpButton" && Base.Player.iLevel >= Config.MIN_LEVEL_PVP)
         {
            return;
         }
         if(param1.currentTarget.name == "questButton" && Base.Player.iLevel >= Config.MIN_LEVEL_QUESTS)
         {
            return;
         }
         if(param1.currentTarget.name == "survivalButton" && Base.Player.iLevel >= Config.MIN_LEVEL_SURVIVAL)
         {
            return;
         }
         if(param1.currentTarget.name == "tournamentButton" && Base.Player.iLevel >= Config.MIN_LEVEL_TOURNAMENT && parseInt(Base.Items.globals.TOURNAMENT_ACTIVATED) == 1)
         {
            return;
         }
         this.tooltip = new TooltipSimbolosAtaqueMC();
         this.bgBar.iconMenuWorld.addChild(this.tooltip);
         this.tooltip.x = param1.currentTarget.x;
         this.tooltip.y = param1.currentTarget.y - 28;
         if(param1.currentTarget.name == "pvpButton")
         {
            TextFieldUtil.setHTML(this.tooltip.tx,"Unlock level " + Config.MIN_LEVEL_PVP.toString());
         }
         else if(param1.currentTarget.name == "questButton")
         {
            TextFieldUtil.setHTML(this.tooltip.tx,"Unlock level " + Config.MIN_LEVEL_QUESTS.toString());
         }
         else if(param1.currentTarget.name == "survivalButton")
         {
            TextFieldUtil.setHTML(this.tooltip.tx,"Unlock level " + Config.MIN_LEVEL_SURVIVAL.toString());
         }
         else if(param1.currentTarget.name == "tournamentButton")
         {
            if(parseInt(Base.Items.globals.TOURNAMENT_ACTIVATED) == 1)
            {
               TextFieldUtil.setHTML(this.tooltip.tx,"Unlock level " + Config.MIN_LEVEL_TOURNAMENT.toString());
            }
            else
            {
               TextFieldUtil.setHTML(this.tooltip.tx,"Under maintenance");
            }
         }
      }
      
      public function removeTooltipWorld(param1:Event) : void
      {
         if(this.tooltip != null)
         {
            this.bgBar.iconMenuWorld.removeChild(this.tooltip);
            this.tooltip = null;
         }
      }
      
      private function openPopupTournament(param1:MouseEvent) : void
      {
         if(Base.Player.iLevel >= Config.MIN_LEVEL_TOURNAMENT && parseInt(Base.Items.globals.TOURNAMENT_ACTIVATED) == 1)
         {
            this.bgBar.iconMenuWorld.visible = false;
            TournamentManager.openPopupTournament();
         }
      }
      
      private function openPopupSurvival(param1:MouseEvent) : void
      {
         if(Base.Player.iLevel >= Config.MIN_LEVEL_SURVIVAL)
         {
            this.bgBar.iconMenuWorld.visible = false;
            Base.PopUp.openPopupSurvival();
         }
      }
      
      public function goQuests(param1:MouseEvent) : void
      {
         if(Base.Player.iLevel >= Config.MIN_LEVEL_QUESTS)
         {
            this.bgBar.iconMenuWorld.visible = false;
            Base.Missions.lestSailDone = true;
            PopupQuestsManager.loadWorldBarco(param1);
         }
      }
      
      public function blockButtonsHerramientas() : void
      {
         this.bgBar.storeButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.storeButtMouse1);
         this.bgBar.gamesButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.openGamesMenu);
         this.bgBar.giftButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.openGiftMenu);
         this.bgBar.achievementsButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.openWorldMenu);
         this.bgBar.recolectaRapido.removeEventListener(MouseEvent.CLICK,this.dongleButtMouse1);
         this.bgBar.bulldozer.removeEventListener(MouseEvent.CLICK,this.bulldozeMouse);
      }
      
      public function get viralButtonPanel() : IconPanel
      {
         return this._viralButtonPanel;
      }
      
      public function createViralButtons(param1:Boolean = false, param2:String = null, param3:String = null) : void
      {
         var _loc4_:DealSpotNPPIcon = null;
         this._viralButtonPanel = new IconPanel(100,IconPanel.SIDE_RIGHT,200);
         this._viralButtonPanel.x = 760;
         this._viralButtonPanel.y = -380;
         addChildAt(this._viralButtonPanel,0);
         KompuManager.api.checkViralButton();
         if(param1 || Base.Main.hasIphoneStorage)
         {
            this.showMobileGiftsViralButton();
         }
         if(Config.FB_PROMO_URI.indexOf("http") == 0)
         {
            _loc4_ = new DealSpotNPPIcon(Config.FB_PROMO_URI);
            this._viralButtonPanel.addIcon(_loc4_,this.removeDealSpotViralIcon);
         }
         CrossManager.api.checkViralButton();
         if(param1 || Config.COME_BACK_2ND_3RD && Base.Main.daysSinceRegistration <= 2 && Base.Player.iLevel >= 4)
         {
            if(Base.Player.privateState.comebackBonusCollected.indexOf(2) == -1)
            {
               this.showComeback2nd3rd();
            }
         }
         if(param1 || Base.Main.showMondayBonus)
         {
            this.showMondayBonusViralButtons();
         }
         if(param1 || Base.Player.iLevel >= 10 && !Base.Player.publishActions)
         {
            this.askPermission = new OkMakeyMC();
            this._viralButtonPanel.addIcon(this.askPermission,this.askPermissionClick,Language.getLiteral(Language.TOOLTIP_ASK_ACHIEVEMENTS));
         }
      }
      
      public function removeDealSpotViralIcon(param1:*) : void
      {
         var _loc2_:DealSpotNPPIcon = null;
         if(param1 is MouseEvent)
         {
            _loc2_ = param1.currentTarget as DealSpotNPPIcon;
         }
         else
         {
            _loc2_ = param1 as DealSpotNPPIcon;
         }
         this._viralButtonPanel.removeIcon(_loc2_);
      }
      
      public function openLore(param1:Event = null) : void
      {
         this._viralButtonPanel.removeIcon(this.iconGods);
         Base.PopUp.openLore("Gods & Colossus",[{
            "image":"gods_1.jpg",
            "text":Language.getLiteral(Language.GODS_1)
         },{
            "image":"gods_2.jpg",
            "text":Language.getLiteral(Language.GODS_2)
         },{
            "image":"gods_3.jpg",
            "text":Language.getLiteral(Language.GODS_3)
         },{
            "image":"gods_4.jpg",
            "text":""
         }]);
      }
      
      public function showDailybonusViralButtons() : void
      {
         this.dailyButton = new DailyButtonMC();
         this._viralButtonPanel.addIcon(this.dailyButton,this.dailyButtonClick,Language.getLiteral(Language.TOOLTIP_BONO_DIARIO));
      }
      
      public function showMondayBonusViralButtons() : void
      {
         if(!this.mondayBonusButton)
         {
            this.mondayBonusButton = new MondayBonusButton();
         }
         else
         {
            this.mondayBonusButton.update();
         }
         this._viralButtonPanel.addIcon(this.mondayBonusButton,this._mondayBonusClickHandler,"Get your Monday Bonus!");
      }
      
      public function showMobileGiftsViralButton() : void
      {
         if(!this.mobileGiftsButton)
         {
            this.mobileGiftsButton = new MobileGuiGiftButton();
         }
         this._viralButtonPanel.addIcon(this.mobileGiftsButton,null,"View Mobile Gifts!");
      }
      
      public function showComeback2nd3rd(param1:Event = null) : void
      {
         if(!this.iconComeBack2nd3rd)
         {
            this.iconComeBack2nd3rd = new IconComeBack2nd3rdMC();
         }
         this._viralButtonPanel.addIcon(this.iconComeBack2nd3rd,this.openComeback2nd3rd,Language.getLiteral(Language.ICON_COMEBACK2ND3RD_TOOLTIP));
      }
      
      public function showIconVideos() : void
      {
         if(!this.iconVideo)
         {
            this.iconVideo = new IconVideoMC();
         }
         this._viralButtonPanel.addIcon(this.iconVideo,this.iconVideoClickHandler,Language.getLiteral(Language.ICON_VIDEOS_TOOLTIP));
      }
      
      private function iconVideoClickHandler(param1:MouseEvent) : void
      {
         if(!Base.Main.tutorialMode)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("gotoAdVideo");
            }
         }
         this._viralButtonPanel.removeIcon(this.iconVideo);
         this.iconVideo = null;
      }
      
      private function _mondayBonusClickHandler(param1:MouseEvent) : void
      {
         if(!Base.Main.tutorialMode)
         {
            this.openMondayBonusPopUp();
         }
      }
      
      private function _mobileGiftsButtonClickHandler(param1:MouseEvent) : void
      {
         if(!Base.Main.tutorialMode)
         {
            Base.PopUp.openPopupMobileGifts();
         }
      }
      
      public function openMondayBonusPopUp() : void
      {
         Base.PopUp.openPopupMondayBonus();
      }
      
      public function openComeback2nd3rd(param1:MouseEvent = null) : void
      {
         Base.PopUp.openComeBackBonus();
      }
      
      public function hideMondayBonusButton() : void
      {
         this._viralButtonPanel.removeIcon(this.mondayBonusButton);
         this.mondayBonusButton = null;
      }
      
      public function showMenVsWomenButton() : void
      {
         this.menVsWomenButton = new MenVsWomenMC();
         this._viralButtonPanel.addIcon(this.menVsWomenButton,this.menVsWomenButtonClick,"Social Wars");
      }
      
      public function showDragonCityButton() : void
      {
         this.dragonCityBtn = new dragonCityMC();
         this._viralButtonPanel.addIcon(this.dragonCityBtn,this.dragonCityButtonClick,"Dragon City");
      }
      
      public function hideComebackBonus() : void
      {
         if(this.iconComeBack2nd3rd != null)
         {
            this._viralButtonPanel.removeIcon(this.iconComeBack2nd3rd);
            this.iconComeBack2nd3rd = null;
         }
      }
      
      private function shakeOfferButton(param1:TimerEvent = null) : void
      {
         if(this.offerButton != null && this.offerButton.star != null)
         {
            this.offerButton.star.play();
         }
      }
      
      public function hideViralButtons() : void
      {
         if(this._viralButtonPanel != null)
         {
            this._viralButtonPanel.visible = false;
         }
      }
      
      private function achievementsButtonClick(param1:MouseEvent) : void
      {
         if(Base.Player.iLevel >= Config.MIN_LEVEL_PVP)
         {
            this.bgBar.iconMenuWorld.visible = false;
            this.showWorld(null);
         }
      }
      
      private function addCashButtonClick(param1:MouseEvent) : void
      {
         if(!Base.Main.tutorialMode)
         {
            Base.Main.gotoGold();
            Base.Main.setMouseToInquire();
         }
      }
      
      private function likeButtonClick(param1:MouseEvent) : void
      {
         Base.Main.likeApplication();
         Base.Main.setMouseToInquire();
      }
      
      private function dailyButtonClick(param1:MouseEvent) : void
      {
         if(!Base.Main.tutorialMode)
         {
            Base.PopUp.openPopupNewDaily();
            this._viralButtonPanel.removeIcon(this.dailyButton);
            this.dailyButton = null;
         }
      }
      
      private function offerButtonClick(param1:MouseEvent) : void
      {
         if(!Base.Main.tutorialMode)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("gotoBuy",Base.Main.offerType);
            }
            this._viralButtonPanel.removeIcon(this.offerButton);
            this.offerButton = null;
         }
      }
      
      private function askPermissionClick(param1:MouseEvent) : void
      {
         if(!Base.Main.tutorialMode)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("askForAchievementPermission");
            }
            this._viralButtonPanel.removeIcon(this.askPermission);
            this.askPermission = null;
         }
      }
      
      private function menVsWomenButtonClick(param1:MouseEvent) : void
      {
         if(!Base.Main.tutorialMode)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("openGame","SW");
            }
            this._viralButtonPanel.removeIcon(this.menVsWomenButton);
            this.menVsWomenButton = null;
         }
      }
      
      private function dragonCityButtonClick(param1:MouseEvent) : void
      {
         if(!Base.Main.tutorialMode)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("openGame","DC");
            }
            this._viralButtonPanel.removeIcon(this.dragonCityBtn);
            this.dragonCityBtn = null;
         }
      }
      
      public function createStore() : void
      {
         var loc3:Number;
         this.storeWindow = this.addChild(new StoreMC());
         this.storeWindow.x = 0;
         this.storeWindow.y = -500;
         this.storeWindow.visible = false;
         this.storeWindow.closeButt.addEventListener(MouseEvent.MOUSE_UP,this.closeStoreHandler);
         TextFieldUtil.setHTML(this.storeWindow.coinText,this.getFormattedNumber(Base.Player.iGold));
         TextFieldUtil.setHTML(this.storeWindow.dollarText,this.getFormattedNumber(Base.Player.iCash));
         TextFieldUtil.setHTML(this.storeWindow.woodText,this.getFormattedNumber(Base.Player.iWood));
         TextFieldUtil.setHTML(this.storeWindow.stoneText,this.getFormattedNumber(Base.Player.iStone));
         TextFieldUtil.setHTML(this.storeWindow.foodText,this.getFormattedNumber(Base.Player.iFood));
         this.storeWindow.btnCash.addEventListener(MouseEvent.MOUSE_UP,Base.Main.gotoCash);
         this.storeWindow.btnCash.addEventListener(MouseEvent.MOUSE_OVER,function(param1:MouseEvent):void
         {
            param1.currentTarget.scaleX = param1.currentTarget.scaleY = 1.05;
         });
         this.storeWindow.btnCash.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):void
         {
            param1.currentTarget.scaleX = param1.currentTarget.scaleY = 1;
         });
         this.storeWindow.btnCash.buttonMode = true;
         this.txtFilter = TextField(this.storeWindow.getChildByName("txtFilter"));
         loc3 = 1;
         this.tabs.push(null);
         while(loc3 < this.numTabsStore)
         {
            this.tabs.push(this.storeWindow.addChild(new Tab(Base.Main,this,135 + loc3 * 65,60,loc3)));
            loc3++;
         }
         this.tabs.push(null);
         this.tabs.push(null);
         this.tabs.push(null);
         this.tabs.push(null);
         this.tabs.push(this.storeWindow.addChild(new Tab(Base.Main,this,130,60,Config.CATEGORIA_MODE_NEW)));
         this.setChildIndex(this.storeWindow,this.numChildren - 1);
         this.tabs[1].mouseUsed();
      }
      
      public function destroy() : *
      {
         var _loc1_:* = null;
         Base.Main.getStage().removeEventListener(MouseEvent.MOUSE_OVER,this.rufflefixHoverCheck,true);
         Base.Main.getStage().removeEventListener(MouseEvent.MOUSE_MOVE,this.rufflefixHoverCheck,true);
         Base.Main.removeEventListener(Event.ADDED,this.rufflefixSelectorAdded);
         mouseChildren = false;
         mouseEnabled = false;
         var _loc2_:* = 0;
         var _loc3_:* = this.buttons;
         for each(_loc1_ in _loc3_)
         {
            if(_loc1_ != null)
            {
               _loc1_.destroy();
            }
         }
         Base.Main.getStage().removeEventListener(FullScreenEvent.FULL_SCREEN,this.onFullscreenChange);
         this.buttons[7].removeEventListener(MouseEvent.CLICK,this.toggleFullscreen);
         this.bgBar.returnHome.removeEventListener(MouseEvent.MOUSE_DOWN,this.returnToMap);
         this.bgBar.normalMouse.removeEventListener(MouseEvent.MOUSE_DOWN,this.openMouseMenu);
         this.bgBar.bulldozer.removeEventListener(MouseEvent.MOUSE_DOWN,this.bulldozeMouse);
         this.experienceBar.btnWorld.removeEventListener(MouseEvent.ROLL_OVER,this.showMapToolTip);
         this.experienceBar.btnWorld.removeEventListener(MouseEvent.ROLL_OUT,this.hideToolTip);
         this.experienceBar.nameText.removeEventListener(MouseEvent.MOUSE_OVER,this.showExperienceToolTip);
         this.experienceBar.nameText.removeEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
         this.experienceBar.nameText.removeEventListener(MouseEvent.MOUSE_DOWN,this.popUpNameTown);
         this.countdownTimer.destroy();
         this.countdownTimer = null;
         this.countdownTimerOgres.destroy();
         this.countdownTimerOgres = null;
         this.countdownAssault.destroy();
         this.countdownAssault = null;
         parent.removeChild(this);
      }
      
      public function destroyGuiButton(param1:String) : void
      {
         switch(param1)
         {
            case "like":
               if(this.likeButton != null)
               {
                  this._viralButtonPanel.removeIcon(this.likeButton);
                  this.likeButton = null;
               }
               break;
            case "bookmark":
               if(this.bookmarkButton != null)
               {
                  this._viralButtonPanel.removeIcon(this.bookmarkButton);
                  this.bookmarkButton = null;
               }
               break;
            case "neighbor":
               if(this.viralNeighborButton != null)
               {
                  this._viralButtonPanel.removeIcon(this.viralNeighborButton);
                  this.viralNeighborButton = null;
               }
               break;
            case "gifts":
               if(this.viralGiftsButton != null)
               {
                  this._viralButtonPanel.removeIcon(this.viralGiftsButton);
                  this.viralGiftsButton = null;
               }
         }
      }
      
      public function addGuiCover(param1:DisplayObject, param2:Number = 0.85) : *
      {
         this.removeGuiCover(param1);
         Base.Main.mapLocked = true;
         this.buttonCover = DisplayObjectContainer(param1).addChild(new GuiCover());
         this.setChildIndex(this.storeWindow,this.numChildren - 1);
         this.buttonCover.width = Base.Main.getStage().stageWidth;
         this.buttonCover.height = Base.Main.getStage().stageHeight;
         this.buttonCover.alpha = param2;
         if(x > 0)
         {
            this.buttonCover.x = -x;
            this.buttonCover.y = -525 + this.fullscreenYShift;
         }
         else
         {
            this.buttonCover.y = -525;
            this.buttonCover.x = 0;
         }
         this.buttonCover.addEventListener(MouseEvent.CLICK,this.onVoid);
         this.buttonCover.addEventListener(MouseEvent.MOUSE_DOWN,this.onVoid);
         this.buttonCover.addEventListener(MouseEvent.MOUSE_UP,this.onVoid);
      }
      
      public function onVoid(param1:Event) : void
      {
         param1.stopImmediatePropagation();
      }
      
      public function mouseUsed() : *
      {
      }
      
      public function resetWindow() : *
      {
         this.bgBar.giftCounter.visible = Base.Main.gifts.length > 0;
         TextFieldUtil.setHTML(this.bgBar.giftCounter.count,String(Base.Main.gifts.length));
         if(this.currentMenu)
         {
            this.currentMenu.resetWindow();
         }
      }
      
      public function toggleSound(param1:Event = null) : *
      {
         this.options_panel.bs.visible = !this.options_panel.bs.visible;
         this.options_panel.bso.visible = !this.options_panel.bso.visible;
         if(Base.Main.settings.data.sfx)
         {
            Base.Sound.stopSfx();
         }
         else
         {
            Base.Sound.startSfx();
         }
         Base.Main.setMouseToInquire();
      }
      
      public function addTimer() : void
      {
         if(this.countdownTimer != null)
         {
            this.countdownTimer.setTimer();
            return;
         }
         this.countdownTimer = new CountdownTimer(Base.Main,this,Language.getLiteral(Language.TIMER_PROXIMA_RECOLECCION),Language.getLiteral(Language.TIMER_RECOLECCION_LISTA),6579300);
         this.countdownTimer.x = 10;
         this.countdownTimer.y = -100;
         this.countdownTimer.visible = false;
         this.countdownTimerOgres = new CountdownTimer(Base.Main,this,Language.getLiteral(Language.TIMER_CAMPAMENTO_ENEMIGO),"",8388608);
         this.countdownTimerOgres.x = 0;
         this.countdownTimerOgres.y = 0;
         this.countdownAssault = new CountdownTimer(Base.Main,this,Language.getLiteral(Language.TIMER_EJERCITO_ENEMIGO),"",8388608);
         this.countdownAssault.x = 0;
         this.countdownAssault.y = 0;
         addChildAt(this.countdownTimer,getChildIndex(this.bgBar) - 1);
         this.bgBar.mcTrolls.addChild(this.countdownTimerOgres);
         this.bgBar.mcTrolls.addChild(this.countdownAssault);
         if(Base.Main.gameMode == Constants.GAME_MODE_ASSAULT || Base.Main.gameMode == Constants.GAME_MODE_SURVIVAL || Base.Main.gameMode == Constants.GAME_MODE_TOURNAMENT)
         {
            this.countdownAssault.visible = true;
            this.countdownTimer.visible = false;
            this.setVisibleTimerOgres(false);
         }
         else if(Base.Main.gameMode != Constants.GAME_MODE_NORMAL || Base.Main.tutorialMode)
         {
            this.countdownAssault.visible = false;
            this.countdownTimer.visible = false;
            this.setVisibleTimerOgres(false);
         }
         else
         {
            this.countdownAssault.visible = false;
            this.setVisibleTimerOgres(true);
         }
      }
      
      private var rufflefixGuiHovered:Boolean = false;
      
      private function mouseOver(param1:MouseEvent) : *
      {
         this.rufflefixGuiHovered = true;
         Base.Main.disableMap();
      }
      
      // RUFFLE FIX: while the mouse button is held, the game redraws a drag-selection box
      // (Base.selectorSquare) under the cursor every frame. On a simple click it has zero size;
      // Flash does not hit-test that, but Ruffle does, so the clicked unit gets MOUSE_OUT and the
      // click falls through to the building behind it. Make the tiny box transparent to the mouse
      // (same 3px threshold the game uses to decide whether it was a real box selection).
      private function rufflefixSelectorAdded(param1:Event) : void
      {
         if(param1.target == null || param1.target != Base.Main.selectorSquare)
         {
            return;
         }
         var _loc2_:Sprite = param1.target as Sprite;
         if(_loc2_ == null || Base.Main.buildingLayer == null)
         {
            return;
         }
         if(Math.abs(Base.Main.squareInitX - Base.Main.buildingLayer.mouseX) <= 3 && Math.abs(Base.Main.squareInitY - Base.Main.buildingLayer.mouseY) <= 3)
         {
            _loc2_.mouseEnabled = false;
         }
      }
      
      // RUFFLE FIX: Ruffle does not send MOUSE_OUT to the GUI when the hovered GUI element
      // is removed from the display list (e.g. the Train button after training). Flash does.
      // Without it the map stays disabled and ground clicks are ignored. Emulate Flash here.
      private function rufflefixHoverCheck(param1:MouseEvent) : void
      {
         if(!this.rufflefixGuiHovered)
         {
            return;
         }
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_ == null || _loc2_ == this || this.contains(_loc2_))
         {
            return;
         }
         this.mouseOut(param1);
      }
      
      public function showCustomToolTip(param1:int, param2:int, param3:String, param4:Boolean = true, param5:String = "left") : *
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,param3,param1,param2,param5));
      }
      
      public function levelUp(param1:Object) : *
      {
         Base.Commands.addCommand({
            "cmd":Constants.CMD_RT_LEVEL_UP,
            "args":[param1.l]
         },true);
         Base.Commands.sendCommands();
         TextFieldUtil.setHTML(this.experienceBar.levelText,param1.l);
         this.adjustStats();
      }
      
      public function hideToolTip(... rest) : *
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
      }
      
      private function dongleButtMouse1(param1:MouseEvent = null) : void
      {
         if(!Base.Main.tutorialMode && Base.Main.gameMode == Constants.GAME_MODE_NORMAL)
         {
            Base.Main.setMouseToInquire();
            Base.Sound.playSfx(SoundManager.SFX_BUTTON_CLICK);
            this.beginMassCollect();
            Base.Main.setMouseToDongle();
            this.hideToolTip();
         }
      }
      
      public function beginMassCollect(param1:MouseEvent = null) : void
      {
         if(!Base.Main.tutorialMode)
         {
            Base.Main.setMouseToInquire();
            Base.Main.spdclct = true;
            Base.Main.setMouseToDongle();
         }
      }
      
      public function adjustStats() : *
      {
         if(Base.Main.gameMode != Constants.GAME_MODE_NORMAL)
         {
            return;
         }
         TextFieldUtil.setHTML(this.coinText,this.getFormattedNumber(Base.Player.iGold));
         TextFieldUtil.setHTML(this.dollarText,this.getFormattedNumber(Base.Player.iCash));
         TextFieldUtil.setHTML(this.woodText,this.getFormattedNumber(Base.Player.iWood));
         TextFieldUtil.setHTML(this.stoneText,this.getFormattedNumber(Base.Player.iStone));
         TextFieldUtil.setHTML(this.foodText,this.getFormattedNumber(Base.Player.iFood));
         TextFieldUtil.setHTML(this.storeWindow.coinText,this.getFormattedNumber(Base.Player.iGold));
         TextFieldUtil.setHTML(this.storeWindow.dollarText,this.getFormattedNumber(Base.Player.iCash));
         TextFieldUtil.setHTML(this.storeWindow.woodText,this.getFormattedNumber(Base.Player.iWood));
         TextFieldUtil.setHTML(this.storeWindow.stoneText,this.getFormattedNumber(Base.Player.iStone));
         TextFieldUtil.setHTML(this.storeWindow.foodText,this.getFormattedNumber(Base.Player.iFood));
         if(Base.Main.currentFriend != "")
         {
            this.experienceBar.expMask.scaleX = 0;
            TextFieldUtil.setHTML(this.experienceBar.exp,Base.Player.playerInfo.name);
            this.enableExperienceBar(false);
         }
         else
         {
            this.experienceBar.expMask.scaleX = (Base.Player.iExperience - Base.Player.uiExpMin) / (Base.Player.uiExpMax - Base.Player.uiExpMin);
            TextFieldUtil.setHTML(this.experienceBar.exp,"" + Base.Player.iExperience + "/" + Base.Player.uiExpMax);
            TextFieldUtil.setHTML(this.experienceBar.levelText,"" + Base.Player.iLevel);
            this.enableExperienceBar(true);
         }
         TextFieldUtil.setHTML(this.experienceBar.visitorsText,Base.Player.iPopulationCurrent + "/" + Base.Player.iPopulationMax);
         if(Base.Player.iPopulationCurrent > Base.Player.iPopulationMax)
         {
            this.experienceBar.visitorsText.textColor = 16711680;
         }
         else if(Base.Player.iPopulationMax >= Config.MAX_POPULATION + Base.Iso.getAdditionalPopulation())
         {
            this.experienceBar.visitorsText.textColor = 255;
         }
         else
         {
            this.experienceBar.visitorsText.textColor = 0;
         }
      }
      
      public function setPlayerInfo() : *
      {
         this.setTownName();
         this.adjustStats();
      }
      
      public function setAssaultStats(param1:Object, param2:Object) : *
      {
         TextFieldUtil.setHTML(this.barraAttackArriba.nameText,param1.map_names[0]);
         if(param1.pid == Constants.FAKE_NEIGHBOURS_USER2_MAP || param1.pid == Constants.FAKE_NEIGHBOURS_USER3_MAP || Utils.inArray(param1.pid,Constants.FAKE_NEIGHBOURS_USER1_MAP.split(",")))
         {
            TextFieldUtil.setHTML(this.barraAttackArriba.exp,Base.Main.friendsInfoMap[param1.pid]["name"]);
            TextFieldUtil.setHTML(this.barraAttackArriba.levelText,Base.Main.friendsInfoMap[param1.pid]["level"]);
         }
         else
         {
            TextFieldUtil.setHTML(this.barraAttackArriba.exp,param1.name);
            if(param2 != null)
            {
               TextFieldUtil.setHTML(this.barraAttackArriba.levelText,param2.level);
            }
            else
            {
               TextFieldUtil.setHTML(this.barraAttackArriba.levelText,"");
            }
         }
      }
      
      public function visitNeighbor() : *
      {
         Base.Main.setMouseToInquire();
         this.bgBar.returnHome.visible = true;
         this.bgBar.returnHome.gotoAndStop(1);
         this.bgBar.iconMenuWorld.visible = false;
         this.countdownTimer.visible = false;
         this.setVisibleTimerOgres(false);
         this.countdownAssault.visible = false;
         if(this._viralButtonPanel != null)
         {
            this._viralButtonPanel.visible = false;
         }
         this.parteArribaGui.gotoAndStop(2);
         this.refreshNeighbourStats();
      }
      
      public function setNeighborStats(param1:Object) : *
      {
         TextFieldUtil.setHTML(this.experienceBar.nameText,param1.playerInfo.map_names[0]);
         this.experienceBar.expMask.scaleX = 0;
         if(param1.playerInfo.pid == Constants.FAKE_NEIGHBOURS_USER2_MAP || param1.playerInfo.pid == Constants.FAKE_NEIGHBOURS_USER3_MAP || Utils.inArray(param1.playerInfo.pid,Constants.FAKE_NEIGHBOURS_USER1_MAP.split(",")))
         {
            TextFieldUtil.setHTML(this.experienceBar.exp,Base.Main.friendsInfoMap[param1.playerInfo.pid]["name"]);
            TextFieldUtil.setHTML(this.experienceBar.levelText,Base.Main.friendsInfoMap[param1.playerInfo.pid]["level"]);
         }
         else
         {
            TextFieldUtil.setHTML(this.experienceBar.exp,param1.playerInfo.name);
            TextFieldUtil.setHTML(this.experienceBar.levelText,param1.map.level);
         }
         this.enableExperienceBar(false);
         TextFieldUtil.setHTML(this.coinText,param1.map.coins);
         TextFieldUtil.setHTML(this.dollarText,param1.playerInfo.cash);
         TextFieldUtil.setHTML(this.woodText,param1.map.wood);
         TextFieldUtil.setHTML(this.stoneText,param1.map.stone);
         TextFieldUtil.setHTML(this.foodText,param1.map.food);
      }
      
      public function refreshNeighbourStats() : *
      {
         var _loc1_:int = NeighbourManager.NUM_CLICKS_ASSIST - NeighbourManager.arNeighbourClicks.length;
         if(Base.Main.currentFriendObject.assist == "0" || !NeighbourManager.friendNotAssisted(Base.Main.currentFriendObject.fbid))
         {
            this.toggleRayosNeighbour(0);
            Tracing.Trace("ASSIST: no quedan clicks");
         }
         else
         {
            this.toggleRayosNeighbour(_loc1_);
         }
      }
      
      private function toggleRayosNeighbour(param1:int) : void
      {
         if(param1 >= 5)
         {
            this.parteArribaGui.rayoNeighbour_05.visible = true;
            this.parteArribaGui.rayoNeighbour_05.alpha = 1;
         }
         else if(this.parteArribaGui.rayoNeighbour_05.visible)
         {
            this.fadeRayoNeighbour(this.parteArribaGui.rayoNeighbour_05);
         }
         if(param1 >= 4)
         {
            this.parteArribaGui.rayoNeighbour_04.visible = true;
            this.parteArribaGui.rayoNeighbour_04.alpha = 1;
         }
         else if(this.parteArribaGui.rayoNeighbour_04.visible)
         {
            this.fadeRayoNeighbour(this.parteArribaGui.rayoNeighbour_04);
         }
         if(param1 >= 3)
         {
            this.parteArribaGui.rayoNeighbour_03.visible = true;
            this.parteArribaGui.rayoNeighbour_03.alpha = 1;
         }
         else if(this.parteArribaGui.rayoNeighbour_03.visible)
         {
            this.fadeRayoNeighbour(this.parteArribaGui.rayoNeighbour_03);
         }
         if(param1 >= 2)
         {
            this.parteArribaGui.rayoNeighbour_02.visible = true;
            this.parteArribaGui.rayoNeighbour_02.alpha = 1;
         }
         else if(this.parteArribaGui.rayoNeighbour_02.visible)
         {
            this.fadeRayoNeighbour(this.parteArribaGui.rayoNeighbour_02);
         }
         if(param1 >= 1)
         {
            this.parteArribaGui.rayoNeighbour_01.visible = true;
            this.parteArribaGui.rayoNeighbour_01.alpha = 1;
         }
         else if(this.parteArribaGui.rayoNeighbour_01.visible)
         {
            this.fadeRayoNeighbour(this.parteArribaGui.rayoNeighbour_01);
         }
      }
      
      private function fadeRayoNeighbour(param1:MovieClip) : void
      {
         var _loc2_:int = 36;
         Tweener.addTween(param1,{
            "x":param1.x - 30,
            "alpha":0,
            "time":1,
            "onComplete":this.hideRayoNeighbour,
            "onCompleteParams":[param1,_loc2_]
         });
      }
      
      private function hideRayoNeighbour(param1:MovieClip, param2:int) : void
      {
         param1.visible = false;
         param1.x = param2;
      }
      
      public function restoreModeNormalfromNeighbour() : *
      {
         Base.Main.setMouseToInquire();
         this.parteArribaGui.gotoAndStop(1);
         this.addCashButton.visible = true;
         this.dollarText.visible = true;
         this.fondoBotonDollar.visible = true;
         this.parteArribaGui.visible = true;
         this.experienceBar.visible = true;
         this.coinText.visible = true;
         this.stoneText.visible = true;
         this.foodText.visible = true;
         this.woodText.visible = true;
         if(this._viralButtonPanel != null)
         {
            this._viralButtonPanel.visible = true;
         }
         barraAttackArriba.visible = false;
      }
      
      public function assaultPlayer() : *
      {
         var _loc1_:Point = null;
         Base.Main.setMouseToInquire();
         this.bgBar.returnHome.visible = true;
         this.bgBar.returnHome.gotoAndStop(2);
         if(Base.Main.currentFriend == Constants.QUEST_SHIP_2 || Base.Main.currentFriend == Constants.QUEST_SHIP)
         {
            this.bgBar.returnHome.gotoAndStop(3);
         }
         this.countdownTimer.visible = false;
         this.setVisibleTimerOgres(false);
         this.countdownAssault.visible = true;
         this.addCashButton.visible = false;
         this.dollarText.visible = false;
         this.fondoBotonDollar.visible = false;
         this.parteArribaGui.visible = false;
         this.experienceBar.visible = false;
         this.coinText.visible = false;
         this.stoneText.visible = false;
         this.foodText.visible = false;
         this.woodText.visible = false;
         if(this._viralButtonPanel != null)
         {
            this._viralButtonPanel.visible = false;
         }
         barraAttackArriba.visible = true;
         barraAttackArriba.gotoAndStop(1);
         if(Base.Main.bModeSpy)
         {
            barraAttackArriba.gotoAndStop(2);
         }
         else if(Base.Main.bModeQuest && Quest.currentQuest is QuestSurvival)
         {
            barraAttackArriba.gotoAndStop(5);
         }
         else if(Base.Main.bModeQuest && (Quest.currentQuest is QuestShip || Quest.currentQuest is QuestZeppelin))
         {
            barraAttackArriba.gotoAndStop(3);
         }
         else if(Base.Main.gameMode == Constants.GAME_MODE_TOURNAMENT)
         {
            barraAttackArriba.gotoAndStop(6);
         }
         if(Base.Main.bModeSpy || Quest.currentQuest is QuestShip || Quest.currentQuest is QuestZeppelin)
         {
            this.hideMagicBox();
         }
         else
         {
            _loc1_ = bgBar.globalToLocal(new Point(0,barraAttackArriba.height + (Base.Main.gameMode == Constants.GAME_MODE_TOURNAMENT ? 20 : 10)));
            bgBar.returnHome.y = _loc1_.y;
            this.showMagicBox();
         }
      }
      
      public function tournamentPlayer() : void
      {
         bgBar.returnHome.y = -81.5;
      }
      
      public function setVisibleTimerOgres(param1:Boolean) : void
      {
         this.countdownTimerOgres.visible = param1;
         this.bgBar.mcTrolls.cara.visible = param1;
         this.bgBar.mcTrolls.buf.visible = false;
         if(param1)
         {
            if(Base.Player.currentRace == Constants.FACTION_HUMAN)
            {
               this.bgBar.mcTrolls.cara.gotoAndStop(1);
            }
            else if(Base.Player.currentRace == Constants.FACTION_HUMAN)
            {
               this.bgBar.mcTrolls.cara.gotoAndStop(2);
            }
         }
      }
      
      public function restoreModeNormalfromAssault() : *
      {
         Base.Main.setMouseToInquire();
         this.addCashButton.visible = true;
         this.dollarText.visible = true;
         this.fondoBotonDollar.visible = true;
         this.countdownAssault.visible = false;
         this.parteArribaGui.visible = true;
         this.experienceBar.visible = true;
         this.coinText.visible = true;
         this.stoneText.visible = true;
         this.foodText.visible = true;
         this.woodText.visible = true;
         if(this._viralButtonPanel != null)
         {
            this._viralButtonPanel.visible = true;
         }
         barraAttackArriba.visible = false;
         bgBar.returnHome.y = -81.5;
         this.showMagicBox();
      }
      
      public function hideViralButtonForTutorial() : void
      {
         if(this._viralButtonPanel != null)
         {
            this._viralButtonPanel.visible = false;
         }
      }
      
      public function setZoom(param1:Number) : *
      {
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuWorld.visible = false;
         Base.Main.settings.data.zoom = param1;
         this.zoomSlider.setValue(param1);
      }
      
      private function toggleQuality() : *
      {
      }
      
      private function onFullscreenChange(param1:FullScreenEvent = null) : void
      {
         var p:Point = null;
         var arg1:FullScreenEvent = param1;
         if(Base.Main.getStage().displayState != StageDisplayState.FULL_SCREEN)
         {
            if(Base.Main.getStage() != null)
            {
               Base.Main.getStage().scaleMode = StageScaleMode.EXACT_FIT;
            }
            if(x > 0)
            {
               this.normalscreen();
               Base.Main.centerBuildings();
            }
            try
            {
               if(Base.PopUp.confirmWindow != null)
               {
                  Base.PopUp.centerConfirmWindow();
               }
               if(Base.PopUp.alertWindow != null)
               {
                  Base.PopUp.centerAlertWindow();
               }
               if(Base.Main.bGamePaused)
               {
                  Base.Main.mcCortinaPaused.scaleX = Base.Main.getStage().stageWidth;
                  Base.Main.mcCortinaPaused.scaleY = Base.Main.getStage().stageHeight;
                  Base.Main.mcGamePaused.x = Base.Main.getStage().stageWidth / 2;
                  Base.Main.mcGamePaused.y = Base.Main.getStage().stageHeight / 2;
               }
            }
            catch(e:Error)
            {
            }
         }
         else
         {
            if(Base.Main.getStage() != null)
            {
               Base.Main.getStage().scaleMode = StageScaleMode.NO_SCALE;
            }
            this.fullscreen();
            Base.Main.centerBuildings();
         }
         if(this.currentWindow != null && Base.Main.getStage() != null)
         {
            this.currentWindow.y = -Base.Main.getStage().stageHeight + this.currentWindow.height + 125;
         }
         if(this.buttonCover != null)
         {
            this.buttonCover.width = Base.Main.getStage().stageWidth;
            this.buttonCover.height = Base.Main.getStage().stageHeight;
            if(x > 0)
            {
               this.buttonCover.x = -x;
               this.buttonCover.y + this.fullscreenYShift;
            }
            else
            {
               this.buttonCover.y = -525;
               this.buttonCover.x = 0;
            }
         }
         Base.Main.moveMap(0,0);
         Base.Main.resizeBGColor();
         this.tTimerOptions.stop();
         this.tTimerOptions.reset();
         this.bOptionsHidden = true;
         this.options_panel.x = 760 + (stage.stageWidth - 760) / 2 - 30;
         if((Base.Main.gameMode == Constants.GAME_MODE_ASSAULT || Base.Main.gameMode == Constants.GAME_MODE_TOURNAMENT || Base.Main.gameMode == Constants.GAME_MODE_SURVIVAL) && !Base.Main.bModeSpy)
         {
            p = bgBar.globalToLocal(new Point(0,barraAttackArriba.height + (Base.Main.gameMode == Constants.GAME_MODE_TOURNAMENT ? 20 : 10)));
            bgBar.returnHome.y = p.y;
         }
         else
         {
            bgBar.returnHome.y = -81.5;
         }
      }
      
      private function setToFullScreen(... rest) : *
      {
      }
      
      private function openMouseMenu(param1:MouseEvent) : void
      {
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuWorld.visible = false;
         this.bgBar.iconMenuGames.visible = false;
         if(Base.Main.forzarQuadrado)
         {
            Base.Main.forzarQuadrado = false;
            Base.Main.removeCursor(true);
         }
         if(Boolean(this.bgBar.iconMenu.visible) || this.bgBar.normalMouse.currentFrame == 2)
         {
            this.returnMouse();
            this.bgBar.iconMenu.visible = false;
         }
         else if(Base.Main.tutorialMode)
         {
            this.returnMouse();
         }
         else
         {
            this.bgBar.iconMenu.visible = true;
         }
      }
      
      private function openWorldMenu(param1:MouseEvent) : void
      {
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuGames.visible = false;
         if(Base.Main.tutorialMode)
         {
            this.returnMouse();
            this.bgBar.iconMenuWorld.visible = false;
         }
         else
         {
            this.bgBar.iconMenuWorld.visible = !this.bgBar.iconMenuWorld.visible;
         }
      }
      
      private function openGiftMenu(param1:MouseEvent) : void
      {
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenuWorld.visible = false;
         this.bgBar.iconMenuGames.visible = false;
         if(Base.Main.tutorialMode)
         {
            this.returnMouse();
            this.bgBar.iconMenuGift.visible = false;
         }
         else
         {
            this.bgBar.iconMenuGift.visible = !this.bgBar.iconMenuGift.visible;
         }
      }
      
      private function openGamesMenu(param1:MouseEvent) : void
      {
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuWorld.visible = false;
         if(Base.Main.tutorialMode)
         {
            this.returnMouse();
            this.bgBar.iconMenuGames.visible = false;
         }
         else
         {
            this.bgBar.iconMenuGames.visible = !this.bgBar.iconMenuGames.visible;
         }
      }
      
      public function activarHerramientaCuadrado(param1:Event = null) : void
      {
         if(Base.Main.tutorialMode)
         {
            return;
         }
         Base.Main.setMouseToInquire();
         Base.Main.setCursor(Constants.CURSOR_SQUARE);
         Base.Main.forzarQuadrado = true;
         Base.Missions.selectionToolUsed = true;
      }
      
      public function abrirSelectorMundo(param1:Event = null) : void
      {
         if(Base.Main.mapaInicializado)
         {
            Base.PopUp.openPopupRaceSelector();
         }
      }
      
      public function abrirDarts(param1:Event = null) : void
      {
         if(Base.Main.mapaInicializado)
         {
            PopupDarts.checkForDartsReset();
            Base.PopUp.openPopupDarts(false);
         }
      }
      
      private function iconMenuMouse(param1:MouseEvent) : void
      {
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuWorld.visible = false;
         this.returnMouse();
      }
      
      private function iconMenuBulldoze(param1:MouseEvent) : void
      {
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuWorld.visible = false;
         this.bulldozeMouse();
         this.bgBar.normalMouse.gotoAndStop(2);
      }
      
      private function iconMenuCollect(param1:MouseEvent) : void
      {
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuWorld.visible = false;
         this.dongleButtMouse1();
         this.bgBar.normalMouse.gotoAndStop(2);
      }
      
      public function menuMassUnitPlace() : void
      {
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuWorld.visible = false;
         this.bgBar.normalMouse.gotoAndStop(2);
      }
      
      private function returnMouse() : void
      {
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuWorld.visible = false;
         this.bgBar.normalMouse.gotoAndStop(1);
         if(Base.Main.tutorialMode)
         {
            return;
         }
         Base.Sound.playSfx(SoundManager.SFX_BUTTON_CLICK);
         Base.Main.setMouseToInquire();
      }
      
      private function setToNormalScreen(... rest) : *
      {
         Base.Main.getStage().removeEventListener(Event.RENDER,this.setToNormalScreen);
      }
      
      private function mouseOut(param1:MouseEvent) : *
      {
         this.rufflefixGuiHovered = false;
         if(this.zoomState == 0 && Base.PopUp.confirmWindow == null && this.expolorationWorld == null || Base.Main.tutorialMode)
         {
            Base.Main.enableMap();
         }
      }
      
      public function toggleMusic(param1:Event = null) : *
      {
         this.options_panel.bm.visible = !this.options_panel.bm.visible;
         this.options_panel.bmo.visible = !this.options_panel.bmo.visible;
         if(this.musicOn)
         {
            Base.Sound.stopBGMusic();
            this.musicOn = false;
            Base.Main.settings.data.music = false;
         }
         else
         {
            if(Base.Player.currentRace == Constants.FACTION_TROLL)
            {
               Base.Sound.startBGMusic(SoundManager.MUSIC_TROLL);
            }
            else
            {
               Base.Sound.startBGMusic(SoundManager.MUSIC_MAP);
            }
            this.musicOn = true;
            Base.Main.settings.data.music = true;
         }
         Base.Main.setMouseToInquire();
      }
      
      public function toggleFullscreen(param1:MouseEvent = null) : void
      {
         if((Base.Main.tutorialMode || (Base.Main.currentFriend == Constants.QUEST_SHIP || Base.Main.currentFriend == Constants.QUEST_SHIP_2) || Base.Main.bModeSpy) && !Base.Main.bAllowAdminPanel)
         {
            return;
         }
         this.options_panel.bf.visible = !this.options_panel.bf.visible;
         this.options_panel.bfo.visible = !this.options_panel.bfo.visible;
         if(Base.Main.getStage().displayState != StageDisplayState.NORMAL)
         {
            Base.Main.getStage().displayState = StageDisplayState.NORMAL;
         }
         else
         {
            Base.Main.getStage().displayState = StageDisplayState.FULL_SCREEN;
         }
      }
      
      private function takePicture() : *
      {
      }
      
      private function mapButtMouse(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         if(!Base.Main.tutorialMode)
         {
            if(Base.PopUp.confirmWindow)
            {
               Base.PopUp.confirmWindow.closeWindow();
            }
            Base.Sound.playSfx(SoundManager.SFX_BUTTON_CLICK);
            Base.Main.setMouseToInquire();
            Base.Main.removeCursor();
            Base.Main.buildingOutline.visible = false;
            Base.Main.shrinkScreenForShare();
            this.bgBar.returnHome.visible = false;
         }
      }
      
      public function enable() : void
      {
         mouseEnabled = true;
         mouseChildren = true;
         this.zoomState = 0;
      }
      
      private function enableExperienceBar(param1:Boolean) : void
      {
         if(param1)
         {
            this.experienceBar.buttonMode = true;
            this.experienceBar.nameText.addEventListener(MouseEvent.MOUSE_OVER,this.showExperienceToolTip);
            this.experienceBar.nameText.addEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
            this.experienceBar.nameText.addEventListener(MouseEvent.MOUSE_DOWN,this.popUpNameTown);
         }
         else
         {
            this.experienceBar.buttonMode = false;
            this.experienceBar.nameText.removeEventListener(MouseEvent.MOUSE_OVER,this.showExperienceToolTip);
            this.experienceBar.nameText.removeEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
            this.experienceBar.nameText.removeEventListener(MouseEvent.MOUSE_DOWN,this.popUpNameTown);
         }
      }
      
      public function returnToMap(... rest) : *
      {
         if(Base.Main.gameMode == Constants.GAME_MODE_NEIGHBOUR)
         {
            this.returnHomeUser();
         }
         else if(Base.Main.gameMode == Constants.GAME_MODE_ASSAULT)
         {
            if(!Base.Main.loadingData && Base.Main.mapaInicializado)
            {
               if(Base.Main.currentFriend == Constants.QUEST_SHIP || Base.Main.currentFriend == Constants.QUEST_SHIP_2)
               {
                  Quest.currentQuest.sendResults();
                  this.returnHomeUser();
                  if(Base.Main.currentFriend == Constants.QUEST_SHIP)
                  {
                     PopupQuestsManager.loadWorldBarco();
                  }
                  else
                  {
                     PopupQuestsManager.loadWorldZeppelin();
                  }
               }
               else if(Base.Main.bModeQuest)
               {
                  Base.PopUp.openPopupQuestFinished();
               }
               else
               {
                  Base.PopUp.openPopupAttackFinished();
               }
            }
         }
         else if(Base.Main.gameMode == Constants.GAME_MODE_SURVIVAL)
         {
            if(!Base.Main.loadingData && Base.Main.mapaInicializado)
            {
               Base.Main.bGamePaused = true;
               Base.PopUp.confirm(Language.getLiteral(Language.SURVIVAL_USER_EXIT),this.goOutSurvivalConfirm,this.goOutSurvivalDeny);
            }
         }
         else if(Base.Main.gameMode == Constants.GAME_MODE_TOURNAMENT)
         {
            TournamentManager.pause();
         }
      }
      
      public function goOutSurvivalDeny() : void
      {
         Base.Main.bGamePaused = false;
      }
      
      public function goOutSurvivalConfirm() : void
      {
         Base.Main.bGamePaused = false;
         (Quest.currentQuest as QuestSurvival).reset();
         Base.Gui.restoreModeNormalfromNeighbour();
         Base.Gui.returnHomeUser();
      }
      
      public function returnHomeUser(param1:Boolean = false, param2:String = "") : void
      {
         Quest.currentQuest = null;
         Base.Main.setMouseToInquire();
         Base.Main.skinMap = Base.Player.skinMap;
         Base.Main.loadMap("",String(Base.Main.townID),Constants.GAME_MODE_NORMAL,false,param1,param2);
         this.bgBar.returnHome.visible = false;
         Base.Sound.playSfx(SoundManager.SFX_BUTTON_CLICK);
         if(this.currentMenu != null && this.currentMenuInd == 6)
         {
            this.currentMenu.resetWindow();
         }
      }
      
      private function bulldozeMouse(... rest) : *
      {
         if(!Base.Main.tutorialMode && Base.Main.gameMode != Constants.GAME_MODE_SURVIVAL)
         {
            Base.Main.setMouseToInquire();
            Base.Main.setMouseToBulldoze();
            Base.Sound.playSfx(SoundManager.SFX_BUTTON_CLICK);
            this.hideToolTip();
         }
      }
      
      private function popUpNameTown(param1:MouseEvent) : void
      {
         Base.Main.setMouseToInquire();
         this.addGuiCover(this);
         Base.Main.addChild(new EnterNamePopUp(Base.Main,0));
      }
      
      public function closeCurrentWindow(... rest) : *
      {
         this.removeGuiCover(this);
         if(this.currentWindow)
         {
            this.currentWindow.destroy();
         }
         this.currentWindow = null;
         Base.Main.mapLocked = false;
         Base.Main.enableMap();
      }
      
      private function openFriendsWindow() : *
      {
      }
      
      public function normalscreen() : *
      {
         if(Base.Main.getStage() == null)
         {
            return;
         }
         Base.Main.getStage().scaleMode = StageScaleMode.EXACT_FIT;
         if(this.zoomState != 0)
         {
            return;
         }
         x = 0;
         y = 525;
         var _loc1_:* = 0;
         while(_loc1_ < this.buttons.length)
         {
            if(this.buttons[_loc1_] != null)
            {
               this.buttons[_loc1_].y = this.buttons[_loc1_].startY;
               this.buttons[_loc1_].x = this.buttons[_loc1_].startX;
            }
            _loc1_++;
         }
         this.experienceBar.y -= this.fullscreenYShift;
         this.parteArribaGui.y -= this.fullscreenYShift;
         this.barraAttackArriba.y -= this.fullscreenYShift;
         this.coinText.y -= this.fullscreenYShift;
         this.stoneText.y -= this.fullscreenYShift;
         this.foodText.y -= this.fullscreenYShift;
         this.woodText.y -= this.fullscreenYShift;
         this.dollarText.y -= this.fullscreenYShift;
         this.zoomSlider.x = Base.Main.getStage().stageWidth - 24;
         this.addCashButton.y -= this.fullscreenYShift;
         this.bgBar.y = Base.Main.getStage().stageHeight - 525 - 124;
         if(this.missionBox != null)
         {
            this.missionBox.y = this.bgBar.y - 71;
            this.missionBox.onNormalScreen();
         }
         if(this.expolorationWorld != null)
         {
            this.expolorationWorld.x = 0;
            this.expolorationWorld.y = 0;
         }
         if(this._viralButtonPanel != null)
         {
            this._viralButtonPanel.x = 760;
         }
      }
      
      public function fullscreen() : *
      {
         if(Base.Main.getStage() != null)
         {
            Base.Main.getStage().scaleMode = StageScaleMode.NO_SCALE;
         }
         y = Base.Main.getStage().stageHeight - 125;
         x = Base.Main.getStage().stageWidth / 2 - 380;
         this.fullscreenXShift = x;
         this.fullscreenYShift = 525 - y;
         var _loc1_:* = 0;
         while(_loc1_ < this.buttons.length)
         {
            if(this.buttons[_loc1_] != null)
            {
               if(_loc1_ < 4)
               {
                  this.buttons[_loc1_].y = this.buttons[_loc1_].y + 525 - y;
               }
               else if(_loc1_ < 9)
               {
                  this.buttons[_loc1_].y = this.buttons[_loc1_].y + 450 - y;
                  this.buttons[_loc1_].x = Base.Main.getStage().stageWidth - 45 - x;
               }
               else
               {
                  this.buttons[_loc1_].y = this.buttons[_loc1_].y + 525 - y;
               }
            }
            _loc1_++;
         }
         this.experienceBar.y = this.experienceBar.y + 525 - y;
         this.parteArribaGui.y = this.parteArribaGui.y + 525 - y;
         this.barraAttackArriba.y = this.barraAttackArriba.y + 525 - y;
         this.coinText.y = this.coinText.y + 525 - y;
         this.foodText.y = this.foodText.y + 525 - y;
         this.woodText.y = this.woodText.y + 525 - y;
         this.stoneText.y = this.stoneText.y + 525 - y;
         this.dollarText.y = this.dollarText.y + 525 - y;
         this.zoomSlider.x = Base.Main.getStage().stageWidth - 24 - x;
         this.addCashButton.y = this.addCashButton.y + 525 - y;
         this.bgBar.y = 0;
         if(this.missionBox != null)
         {
            Tracing.Trace("this.missionBox.y:" + this.missionBox.y);
            this.missionBox.y = this.bgBar.y - 71;
            this.missionBox.onFullScreen(this.fullscreenXShift);
         }
         if(this._viralButtonPanel != null)
         {
            this._viralButtonPanel.x = 760 + (stage.stageWidth - 760) / 2;
         }
      }
      
      private function setTownName() : void
      {
         var _loc1_:String = Base.Player.playerInfo.map_names[Base.Main.townID];
         if(_loc1_ == "My Empire")
         {
            _loc1_ = Language.getLiteral(Language.INFO_EMPIRE_NAME);
         }
         TextFieldUtil.setHTML(this.experienceBar.nameText,_loc1_);
      }
      
      public function openWindow(param1:int) : *
      {
         var _loc2_:* = undefined;
         if(Boolean(this.currentWindow) && this.currentWindowInd == param1)
         {
            return;
         }
         if(this.currentWindow)
         {
            this.currentWindow.destroy();
            this.currentWindow = null;
         }
         _loc2_ = this.currentWindowInd = param1;
         switch(_loc2_)
         {
            case 0:
               break;
            case 1:
               if(Base.Main.getStage().loaderInfo.parameters["gocash"] != null)
               {
                  Base.Main.gotoCash();
               }
               break;
            case 2:
               this.addGuiCover(this);
               this.currentWindow = this.addChild(new FolderMenu(Base.Main,this,0,0,-Base.Main.getStage().stageHeight + (x > 0 ? 250 : 125)));
               break;
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
         }
      }
      
      public function setMenu(param1:int, param2:Boolean = false, param3:int = 0, param4:int = 0) : DisplayObject
      {
         if(this.currentMenuInd == param1 && !param2)
         {
            return this.currentMenu;
         }
         if(this.currentMenu != null)
         {
            this.tabs[this.currentMenuInd].fadeTab();
            this.currentMenu.destroy();
         }
         this.currentMenuInd = param1;
         switch(this.currentMenuInd)
         {
            case 0:
               break;
            case 1:
               this.currentMenu = this.storeWindow.addChild(new BuildingWindow(Base.Main,this,1,73,170,1,param3,param4));
               break;
            case 2:
               this.currentMenu = this.storeWindow.addChild(new BuildingWindow(Base.Main,this,4,73,170,2,param3,param4));
               break;
            case 3:
               this.currentMenu = this.storeWindow.addChild(new BuildingWindow(Base.Main,this,2,73,170,3,param3,param4));
               break;
            case 4:
               this.currentMenu = this.storeWindow.addChild(new BuildingWindow(Base.Main,this,3,73,170,4,param3,param4));
               break;
            case 5:
               if(Base.Main.bModeEditor)
               {
                  this.currentMenu = this.storeWindow.addChild(new BuildingWindow(Base.Main,this,Config.CATEGORIA_MODE_EDITOR,73,170,Config.CATEGORIA_MODE_EDITOR));
               }
               else
               {
                  this.currentMenu = this.storeWindow.addChild(new ExpandTab(Base.Main,this,0,73,170));
               }
               break;
            case 6:
               this.currentMenu = this.storeWindow.addChild(new GiftWindow(Base.Main,this,73,170));
               break;
            case 7:
               this.currentMenu = this.storeWindow.addChild(new BuildingWindow(Base.Main,this,5,73,170,5,param3,param4));
               break;
            case 12:
               this.currentMenu = this.storeWindow.addChild(new BuildingWindow(Base.Main,this,Config.CATEGORIA_MODE_NEW,73,170,Config.CATEGORIA_MODE_NEW,param3,param4));
         }
         this.tabs[this.currentMenuInd].highlightTab();
         return this.currentMenu;
      }
      
      public function updateFilterState() : void
      {
         this.txtFilter.visible = Base.Main.bModeEditor;
         if(this.txtFilter.visible)
         {
            this.createFilter();
         }
         else
         {
            this.destroyFilter();
         }
      }
      
      private function createFilter() : void
      {
         if(!this.txtFilter.hasEventListener(TextEvent.TEXT_INPUT))
         {
            this.txtFilter.addEventListener(TextEvent.TEXT_INPUT,this.onFilterChanged);
            stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            TextFieldUtil.setHTML(this.txtFilter,"");
            this.filter = "";
         }
      }
      
      private function destroyFilter() : void
      {
         if(this.txtFilter.hasEventListener(TextEvent.TEXT_INPUT))
         {
            this.txtFilter.removeEventListener(TextEvent.TEXT_INPUT,this.onFilterChanged);
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            TextFieldUtil.setHTML(this.txtFilter,"");
            this.filter = "";
            if(this.currentMenu != null && this.filter != "")
            {
               this.currentMenu.createButtons();
            }
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         switch(param1.charCode)
         {
            case Keyboard.ENTER:
               this.applyFilter();
               break;
            case Keyboard.DELETE:
            case Keyboard.BACKSPACE:
               this.onFilterChanged();
         }
      }
      
      private function onFilterChanged(param1:TextEvent = null) : void
      {
         if(this.filterTimer != null)
         {
            this.filterTimer.stop();
            this.filterTimer.removeEventListener(TimerEvent.TIMER,this.applyFilter);
            this.filterTimer = null;
         }
         this.filterTimer = new Timer(300,1);
         this.filterTimer.addEventListener(TimerEvent.TIMER,this.applyFilter);
         this.filterTimer.start();
      }
      
      private function applyFilter(param1:TimerEvent = null) : void
      {
         if(param1 != null)
         {
            this.filterTimer.stop();
            this.filterTimer.removeEventListener(TimerEvent.TIMER,this.applyFilter);
            this.filterTimer = null;
         }
         if(this.currentMenu != null && this.currentMenu.createButtons != null)
         {
            this.filter = this.txtFilter.text;
            this.currentMenu.createButtons();
         }
      }
      
      public function removeGuiCover(param1:DisplayObject) : *
      {
         if(this.buttonCover != null)
         {
            this.buttonCover.removeEventListener(MouseEvent.CLICK,this.onVoid);
            this.buttonCover.removeEventListener(MouseEvent.MOUSE_DOWN,this.onVoid);
            this.buttonCover.removeEventListener(MouseEvent.MOUSE_UP,this.onVoid);
            DisplayObjectContainer(param1).removeChild(this.buttonCover);
            this.buttonCover = null;
            Base.Main.mapLocked = false;
         }
      }
      
      public function disable() : void
      {
         mouseEnabled = false;
         mouseChildren = false;
         this.zoomState = 1;
      }
      
      public function getFormattedNumber(param1:int) : String
      {
         var _loc2_:* = "" + param1;
         var _loc3_:* = new Array();
         var _loc4_:* = 0;
         var _loc5_:* = _loc2_.length;
         while(_loc5_ > 0)
         {
            _loc4_ = Math.max(_loc5_ - 3,0);
            _loc3_.unshift(_loc2_.slice(_loc4_,_loc5_));
            _loc5_ = _loc4_;
         }
         return _loc3_.join(",");
      }
      
      public function storeButtMouse1(param1:MouseEvent = null) : void
      {
         Base.Main.placingStoreObject = null;
         if(Base.Main.tutorialMode && Base.Main.tutorial.getStep() != 8 && Base.Main.tutorial.getStep() != 17)
         {
            return;
         }
         if(!Base.Main.tutorialMode)
         {
            Base.Main.setMouseToInquire();
            Base.Main.deseleccionarElementos();
            this.addGuiCover(this);
            this.storeWindow.visible = true;
            this.updateFilterState();
            if(this.missionBox != null)
            {
               this.missionBox.closeAllPopups();
            }
         }
         if(Base.Main.tutorialMode && Base.Main.tutorial.getStep() == 8 && !Base.Main.tabsLocked)
         {
            Base.Main.tutorial.nextStep();
            this.addGuiCover(this);
            this.storeWindow.visible = true;
            this.updateFilterState();
         }
         if(Base.Main.tutorialMode && Base.Main.tutorial.getStep() == 17 && !Base.Main.tabsLocked)
         {
            if(this.missionBox != null)
            {
               this.missionBox.infoOkButtClickHandler();
            }
            Base.Main.tutorial.nextStep();
            this.addGuiCover(this);
            this.storeWindow.visible = true;
            this.updateFilterState();
         }
      }
      
      private function giftButtMouse1(param1:MouseEvent) : void
      {
         if(!Base.Main.tutorialMode)
         {
            this.openStorage();
         }
      }
      
      public function openStorage() : void
      {
         Base.Main.placingStoreObject = null;
         Base.Gui.openStore(6,0,0);
      }
      
      public function openStore(param1:int, param2:int, param3:int) : void
      {
         Base.Main.setMouseToInquire();
         this.addGuiCover(this);
         this.storeWindow.visible = true;
         this.setMenu(param1,true,param3,param2);
         this.updateFilterState();
      }
      
      public function closeStoreHandler(param1:MouseEvent = null) : void
      {
         if(Base.Main.tutorialMode && (Base.Main.tutorial.getStep() == 3 || Base.Main.tutorial.getStep() == 6))
         {
            return;
         }
         this.storeWindow.visible = false;
         this.removeGuiCover(this);
      }
      
      public function addMagicBox(param1:MagicManager) : void
      {
         var _loc2_:PopupMagic = null;
         if(this.magicBox == null)
         {
            Tracing.Trace("CREATING MAGIC BOX");
            _loc2_ = new PopupMagic(0,-80,param1);
            this.magicBox = this.addChildAt(_loc2_,getChildIndex(this.bgBar)) as MovieClip;
         }
      }
      
      public function removeMagicBox() : void
      {
         if(this.magicBox != null)
         {
            this.removeChild(this.magicBox);
            this.magicBox = null;
         }
      }
      
      public function hideMagicBox() : void
      {
         if(this.magicBox != null)
         {
            this.magicBox.visible = false;
         }
      }
      
      public function showMagicBox() : void
      {
         if(this.magicBox != null)
         {
            this.magicBox.visible = true;
            this.magicBox.updateManaLeft();
         }
      }
      
      public function addMisionBox(param1:*) : void
      {
         if(this.missionBox == null)
         {
            this.missionBox = this.addChild(new MissionPopup(16,this.bgBar.y - 71,param1)) as MovieClip;
         }
      }
      
      public function removeMisionBox() : void
      {
         if(this.missionBox != null)
         {
            this.removeChild(this.missionBox);
            Base.Missions.bActive = false;
            this.missionBox = null;
         }
      }
      
      public function showMissionBoxAlertattack(param1:String = null) : void
      {
         if(this.missionBox != null)
         {
            this.missionBox.showAlertAttack(param1);
         }
      }
      
      public function showRecuadro() : void
      {
         if(!this.recuadroShowed)
         {
            this.recuadroShowed = true;
            Base.Gui.recuadroInfo.showSpecialUnitPortraits();
            Tweener.removeTweens(this.bgBar.recuadroInfo);
            Tweener.addTween(this.bgBar.recuadroInfo,{
               "y":-9.5,
               "time":0.7,
               "transition":"linear"
            });
         }
      }
      
      public function hideRecuadro() : void
      {
         if(this.recuadroShowed)
         {
            this.recuadroShowed = false;
            Base.Gui.recuadroInfo.hideSpecialUnitPortraits();
            Tweener.removeTweens(this.bgBar.recuadroInfo);
            Tweener.addTween(this.bgBar.recuadroInfo,{
               "y":123,
               "time":0.7,
               "transition":"linear"
            });
         }
      }
      
      private function showExperienceToolTip(param1:MouseEvent) : void
      {
         Tracing.Trace("showExperienceToolTip");
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,Language.getLiteral(Language.TOOLTIP_CAMBIAR_NOMBRE),this.experienceBar.x + 310,this.experienceBar.y - 15,"right"));
      }
      
      private function showMapToolTip(param1:MouseEvent) : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         var _loc2_:* = Language.getLiteral(Language.TOOLTIP_LUCHA);
         this.toolTip = this.addChild(new ToolTip(this,_loc2_,this.experienceBar.x + 260,this.experienceBar.y + 45,"top"));
      }
      
      private function showAddCashToolTip(param1:MouseEvent) : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         var _loc2_:* = Language.getLiteral(Language.TOOLTIP_GANAR_ORO);
         this.toolTip = this.addChild(new ToolTip(this,_loc2_,param1.currentTarget.x - 90,param1.currentTarget.y - 45,"top",50));
      }
      
      public function showToolTip(param1:int, param2:int, param3:int, param4:Boolean = true, param5:String = "left") : *
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,param4 ? this.tabNames[param3] : this.topNames[param3],param1,param2,param5));
      }
      
      private function showFoodToolTip(param1:MouseEvent) : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,Language.getLiteral(Language.TOOLTIP_RECURSO_COMIDA),param1.currentTarget.x + 20,param1.currentTarget.y + 20,"bottom",50));
      }
      
      private function showWoodToolTip(param1:MouseEvent) : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,Language.getLiteral(Language.TOOLTIP_RECURSO_MADERA),param1.currentTarget.x + 20,param1.currentTarget.y + 20,"bottom",50));
      }
      
      private function showStoneToolTip(param1:MouseEvent) : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,Language.getLiteral(Language.TOOLTIP_RECURSO_PIEDRA),param1.currentTarget.x + 20,param1.currentTarget.y + 20,"bottom",50));
      }
      
      private function showGoldToolTip(param1:MouseEvent) : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,Language.getLiteral(Language.TOOLTIP_RECURSO_ORO),param1.currentTarget.x + 20,param1.currentTarget.y + 20,"bottom",50));
      }
      
      public function showWorld(param1:Event = null, param2:int = 0) : void
      {
         if(Base.Main.gameMode == Constants.GAME_MODE_NORMAL)
         {
            Base.Main.hideArrow();
            Base.Gui.recuadroInfo.clearSpecialUnitPortraits();
            if(Base.Player.iLevel < Config.ATTACKS_MIN_LEVEL)
            {
               Base.PopUp.alert(Language.getLiteral(Language.AVISO_POCO_NIVEL_PARA_CONQUISTAR,[Config.ATTACKS_MIN_LEVEL]));
            }
            else if(this.expolorationWorld == null)
            {
               Base.Main.shrinkScreenForShare(true);
               this.expolorationWorld = new ExplorationsManager(param2);
               Base.Main.addChildAt(this.expolorationWorld,Base.Main.getChildIndex(Base.PopUp.popupLayer));
               if(Base.Main.getStage().displayState == StageDisplayState.FULL_SCREEN)
               {
                  this.expolorationWorld.x = (Base.Main.getStage().stageWidth - 760) / 2;
                  this.expolorationWorld.y = (Base.Main.getStage().stageHeight - 600) / 2;
                  this.expolorationWorld.initFullScreenMode();
               }
            }
            else if(this.expolorationWorld != null)
            {
               Base.Main.shrinkScreenForShare(true);
               this.expolorationWorld.loadContinent(param2);
            }
         }
      }
      
      public function assaultUpdate(param1:int, param2:int) : void
      {
         if(this.barraAttackArriba.goldGained != null)
         {
            TextFieldUtil.setHTML(this.barraAttackArriba.goldGained,param1);
         }
         if(this.barraAttackArriba.xpGained != null)
         {
            TextFieldUtil.setHTML(this.barraAttackArriba.xpGained,param2);
         }
      }
      
      public function panelCollectibleRefresh(param1:int) : void
      {
         var _loc2_:Array = null;
         var _loc3_:TextField = null;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:DisplayObject = null;
         _loc2_ = CollectableManager.getCollection(param1);
         TextFieldUtil.setHTML(this.panelCollection.txCollection,Language.getLiteral(CollectableManager.arCollections[0][param1]));
         _loc6_ = int(_loc2_.length);
         _loc5_ = 1;
         while(_loc5_ < _loc6_)
         {
            _loc3_ = TextField(this.panelCollection.getChildByName("txCollectible" + _loc5_));
            _loc4_ = MovieClip(this.panelCollection.getChildByName("collectible" + _loc5_));
            while(_loc4_.numChildren > 0)
            {
               _loc4_.removeChildAt(0);
            }
            TextFieldUtil.setHTML(_loc3_,"x" + _loc2_[_loc5_][0]);
            _loc7_ = _loc4_.addChild(_loc2_[_loc5_][1].spImage);
            _loc7_.scaleX = 0.75;
            _loc7_.scaleY = 0.75;
            if(_loc2_[_loc5_][0] <= 0)
            {
               _loc7_.alpha = 0.3;
            }
            else
            {
               _loc7_.alpha = 1;
            }
            _loc5_++;
         }
      }
      
      public function panelCollectibleIn(param1:int) : void
      {
         if(this.tTimer != null)
         {
            this.tTimer.stop();
            this.tTimer.removeEventListener(TimerEvent.TIMER,this.panelCollectibleOut);
            this.tTimer = null;
         }
         this.tTimer = new Timer(3000);
         this.tTimer.addEventListener(TimerEvent.TIMER,this.panelCollectibleOut);
         this.tTimer.start();
         this.panelCollectibleRefresh(param1);
         this.panelCollection.y = Base.Gui.experienceBar.y + 69;
         this.panelCollection.x = Base.Main.getStage().stageWidth;
         this.panelCollection.visible = true;
         Tweener.addTween(this.panelCollection,{
            "x":425,
            "time":0.7,
            "transition":"easeOutQuint"
         });
      }
      
      public function panelCollectibleOut(param1:Event = null) : void
      {
         Tweener.addTween(this.panelCollection,{
            "x":Base.Main.getStage().stageWidth,
            "time":0.7,
            "transition":"easeOutQuint",
            "onComplete":this.onPanelCollectibleOut
         });
      }
      
      public function onPanelCollectibleOut() : void
      {
         this.panelCollection.visible = false;
      }
      
      public function collectionButton(param1:Event) : void
      {
         if(Base.Player.currentRace == Constants.FACTION_HUMAN)
         {
            Base.PopUp.openPopupCollections();
         }
         else
         {
            Base.PopUp.alert(Language.getLiteral(Language.AVISO_COLECCION_FACCION));
         }
      }
      
      public function openQuestProgressPopup(param1:MouseEvent) : void
      {
         Base.PopUp.openPopupQuestsManager();
      }
      
      private function onLevelUp(param1:Event = null) : void
      {
         var _loc2_:Object = null;
         var _loc3_:StaticData = null;
         var _loc4_:IsoElement = null;
         if(Base.Player.iLevel == Config.LEVEL_MAGIC && Base.Main.gameMode == Constants.GAME_MODE_NORMAL)
         {
            Base.Gui.removeMisionBox();
            if(Base.Magic == null)
            {
               Base.Magic = MagicManager.getInstance(Base.Items.magicList);
            }
            Base.Gui.addMagicBox(Base.Magic);
            _loc2_ = Base.Iso.encontrarZonaProximaLibre(59,59,3,3,Config.EI_MAP_WIDTH);
            if(_loc2_.encontrado)
            {
               _loc3_ = StaticDataLibrary.api.getItem(Constants.ID_BUILDING_WIZARDRY);
               _loc4_ = Base.Main.addElement(_loc2_.ty * Config.EI_MAP_WIDTH + _loc2_.tx,_loc3_,false,false) as IsoBuilding;
               MapInitializer.buyElementNoResources(_loc4_);
            }
            Base.PopUp.openAlerta(Language.getLiteral(Language.AVISO_GRIMORIO_TITULO),Language.getLiteral(Language.AVISO_GRIMORIO_DESCRIPCION),"alert_magic.jpg");
         }
      }
   }
}

