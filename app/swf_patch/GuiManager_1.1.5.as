package GUI
{
   import GUI.states.GuiState;
   import GUI.states.StateAssault;
   import GUI.states.StateNeighbour;
   import GUI.states.StateNormal;
   import GUI.states.StateSpy;
   import GUI.states.StateTournament;
   import caurina.transitions.*;
   import com.socialpoint.debug.*;
   import com.socialpoint.social.cross.CrossManager;
   import com.socialpoint.statemachine.StateMachine;
   import core.*;
   import core.constants.GameMode;
   import core.isoengine.*;
   import core.statics.*;
   import expansion.*;
   import flash.display.*;
   import flash.events.*;
   import flash.external.ExternalInterface;
   import flash.geom.*;
   import flash.system.ApplicationDomain;
   import flash.text.*;
   import flash.ui.Keyboard;
   import flash.utils.*;
   import managers.*;
   import managers.goals.GoalsManager;
   import managers.offers.KompuManager;
   import newTowns.*;
   import org.osflash.signals.Signal;
   import popups.*;
   import quest.*;
   import utils.TextFieldUtil;
   
   public class GuiManager extends GuiMC
   {
      
      public static var SIG_SELECTION_TOOL_CLICKED:Signal = new Signal();
      
      public static var SIG_GIFT_BUTTON_CLICKED:Signal = new Signal();
      
      public static var SIG_WORLD_BUTTON_CLICKED:Signal = new Signal();
      
      public static var SIG_DAILY_BONUS_CLICKED:Signal = new Signal();
      
      private var machine:StateMachine;
      
      public var bookmarkButton:* = null;
      
      private var etcNames:Array;
      
      private var coinTextStartPos:Point;
      
      public var fullscreenYShift:int = 0;
      
      private var zoomSpeed:Number = 2;
      
      private var startX:int;
      
      private var startY:int;
      
      private var testString:String = "";
      
      private var currentMenuInd:int = 0;
      
      private var currentWindowInd:int = 0;
      
      private var currentMenu:*;
      
      private var zoomState:int = 0;
      
      public var buttons:Array;
      
      private var fullscreenXShift:int = 0;
      
      public var zoomSlider:ZoomSlider;
      
      public var tabs:Array;
      
      public var audioSprites:AudioSheet;
      
      public var countdownTimer:CountdownTimer;
      
      public var countdownTimerOgres:CountdownTimer;
      
      public var countdownAssault:CountdownTimer;
      
      private var buttonCover:* = null;
      
      private var tabNames:Array;
      
      private var dollarTextStartPos:Point;
      
      public var currentWindow:*;
      
      private var toolTip:* = null;
      
      private var testInc:int = 0;
      
      private var topNames:Array;
      
      private var experienceBarStartPos:Point;
      
      private var recolectaRapidoStartX:int;
      
      private var recolectaRapidoStartY:int;
      
      public var sfxOn:Boolean = true;
      
      public var musicOn:Boolean = true;
      
      public var friendsWindow:*;
      
      public var storeWindow:*;
      
      public var numTabsStore:int = 8;
      
      public var likeButton:* = null;
      
      public var missionBox:MissionPopup;
      
      public var magicBox:MovieClip;
      
      private var viralNeighborButton:GuiInviteButton;
      
      private var viralGiftsButton:GuiGiftButton;
      
      public var dailyButton:MovieClip;
      
      private var mondayBonusButton:MondayBonusButton;
      
      private var mobileGiftsButton:MobileGuiGiftButton;
      
      private var iconVideo:IconVideoMC;
      
      private var iconComeBack2nd3rd:IconComeBack2nd3rdMC;
      
      private var menVsWomenButton:MovieClip;
      
      private var dragonCityBtn:dragonCityMC;
      
      private var dragonCityIOSButton:CrossDCiViralIcon;
      
      private var askPermission:MovieClip;
      
      private var offerButton:MovieClip;
      
      public var fbLikeButton:Sprite;
      
      public var recuadroShowed:Boolean;
      
      public var expolorationWorld:ExplorationsManager;
      
      public var recuadroInfo:RecuadroInfoNew;
      
      public var tTimerOptions:Timer;
      
      public var missionOffset:int = 0;
      
      public var iconGods:IconGodsMC;
      
      public var filter:String = "";
      
      private var txtFilter:TextField;
      
      private var filterTimer:Timer;
      
      private var tooltip:TooltipSimbolosAtaqueMC;
      
      public var _viralButtonPanel:IconPanel;
      
      public var sigFullScreenChange:Signal = new Signal(String);
      
      private var bOptionsHidden:Boolean = true;
      
      public var tTimer:Timer;
      
      public function GuiManager(param1:int = 0, param2:int = 0)
      {
         Base.Player.addEventListener(PlayerStatus.EVT_LEVEL_UP,this.onLevelUp);
         this.tabs = new Array(0);
         this.buttons = new Array(0);
         this.audioSprites = new AudioSheet(0,0);
         this.tabNames = new Array(Language.getLiteral(Language.MENU_VECINOS),Language.getLiteral(Language.MENU_CASAS),Language.getLiteral(Language.MENU_DECORACIONES),Language.getLiteral(Language.MENU_DEFENSAS),Language.getLiteral(Language.MENU_EJERCITO),Language.getLiteral(Language.MENU_EXPANSION),Language.getLiteral(Language.MENU_REGALOS),Language.getLiteral(Language.MENU_MARAVILLAS));
         this.topNames = new Array(Language.getLiteral(Language.TOOLTIP_ORO),Language.getLiteral(Language.TOOLTIP_CASH),Language.getLiteral(Language.TOOLTIP_TROFEOS),Language.getLiteral(Language.TOOLTIP_FALTA_POCO),Language.getLiteral(Language.TOOLTIP_MUSICA),Language.getLiteral(Language.TOOLTIP_EFECTOS_SONIDO),Language.getLiteral(Language.TOOLTIP_FOTOS),Language.getLiteral(Language.TOOLTIP_PANTALLA_COMPLETA),Language.getLiteral(Language.TOOLTIP_CALIDAD),Language.getLiteral(Language.TOOLTIP_VOLVER),Language.getLiteral(Language.TOOLTIP_TE_GUSTA));
         this.etcNames = new Array(Language.getLiteral(Language.TOOLTIP_MULTI),Language.getLiteral(Language.TOOLTIP_ELIMINAR),Language.getLiteral(Language.TOOLTIP_INVITACIONES_AMIGOS),Language.getLiteral(Language.TOOLTIP_REGALOS),Language.getLiteral(Language.TOOLTIP_RECOLECTAR),Language.getLiteral(Language.TOOLTIP_TIENDA));
         super();
         Base.Main.getStage().addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreenChange);
         Base.Main.getStage().addEventListener(MouseEvent.MOUSE_OVER,this.rufflefixHoverCheck,true);
         Base.Main.getStage().addEventListener(MouseEvent.MOUSE_MOVE,this.rufflefixHoverCheck,true);
         Base.Main.addEventListener(Event.ADDED,this.rufflefixSelectorAdded);
         this.startX = param1;
         this.startY = param2;
         this.panelCollection.visible = false;
         x = param1;
         y = param2;
         this.recuadroInfo = new RecuadroInfoNew(this.bgBar.recuadroInfo);
         this._initializeStateMachine();
      }
      
      private function _initializeStateMachine() : void
      {
         this.machine = new StateMachine();
         this.machine.addState(GuiState.NORMAL,new StateNormal(this).withFullScreenSignal(this.sigFullScreenChange),[GuiState.ASSAULT,GuiState.EDITOR,GuiState.NEIGHBOUR,GuiState.SPY,GuiState.SURVIVAL,GuiState.TOURNAMENT]);
         this.machine.addState(GuiState.NEIGHBOUR,new StateNeighbour(this),[GuiState.NORMAL]);
         this.machine.addState(GuiState.ASSAULT,new StateAssault(this).withFullScreenSignal(this.sigFullScreenChange),[GuiState.NORMAL,GuiState.SPY]);
         this.machine.addState(GuiState.SPY,new StateSpy(this).withFullScreenSignal(this.sigFullScreenChange),[GuiState.NORMAL,GuiState.ASSAULT]);
         this.machine.addState(GuiState.TOURNAMENT,new StateTournament(this),[GuiState.NORMAL]);
      }
      
      public function setNeighbourMode() : void
      {
         this.machine.setState(GuiState.NEIGHBOUR);
      }
      
      public function setNormalMode() : void
      {
         this.machine.setState(GuiState.NORMAL);
      }
      
      public function setSpyMode() : void
      {
         this.machine.setState(GuiState.SPY);
      }
      
      public function setAssaultMode() : void
      {
         this.machine.setState(GuiState.ASSAULT);
      }
      
      public function setTournamentMode() : void
      {
         this.machine.setState(GuiState.TOURNAMENT);
      }
      
      private function _addGuiListeners() : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
      }
      
      private function _createStore() : void
      {
         this.createStore();
      }
      
      private function _hideElements() : void
      {
         this.bgBar.returnHome.visible = false;
      }
      
      private function _setSettings() : void
      {
         this.musicOn = Boolean(Base.Main.settings.data.music);
      }
      
      private function _handleCashButton() : void
      {
         this.addCashButton.addEventListener(MouseEvent.MOUSE_DOWN,this.addCashButtonClick);
         this.addCashButton.addEventListener(MouseEvent.ROLL_OVER,this.showAddCashToolTip);
         this.addCashButton.addEventListener(MouseEvent.ROLL_OUT,this.hideToolTip);
         this.addCashButton.buttonMode = true;
      }
      
      private function _createFriendsWindow() : void
      {
         this.friendsWindow = this.bgBar.mcFriends.addChild(new FriendsWindow(Base.Main,this,-10,-12));
      }
      
      private function _createButtonsHerramientas() : void
      {
         this.createButtonsHerramientas();
      }
      
      private function _setUpCommonGui() : void
      {
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
         this.zoomSlider = new ZoomSlider();
         this.addChildAt(this.zoomSlider,Math.max(this.getChildIndex(this.bgBar) - 1,0));
      }
      
      public function init() : void
      {
         this._createStore();
         this._createButtonsHerramientas();
         this._createFriendsWindow();
         this._handleCashButton();
         this._setSettings();
         this._addGuiListeners();
         this._hideElements();
         this._setUpCommonGui();
         this.machine.setState(GuiState.NORMAL);
         this._setUpNotifications();
      }
      
      private function _setUpNotifications() : void
      {
         NotificationsManager.api.initialize(Base.Main.addChild(new Sprite()) as DisplayObjectContainer);
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
         GameStatic.setButtonText(bgBar.giftButton.button,Language.ICON_MENU_GIFT_GIFTS);
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
         this.bgBar.btnSelectAll.buttonMode = true;
         this.bgBar.btnSelectAll.addEventListener(MouseEvent.CLICK,this.selectAll,false,0,true);
         this.bgBar.btnSelectAll.addEventListener(MouseEvent.MOUSE_OVER,this.btnMouseOverScale,false,0,true);
         this.bgBar.btnSelectAll.addEventListener(MouseEvent.MOUSE_OUT,this.btnMouseOutScale,false,0,true);
         this.bgBar.btnSelectSpecials.buttonMode = true;
         this.bgBar.btnSelectSpecials.addEventListener(MouseEvent.CLICK,this.selectSpecials,false,0,true);
         this.bgBar.btnSelectSpecials.addEventListener(MouseEvent.MOUSE_OVER,this.btnMouseOverScale,false,0,true);
         this.bgBar.btnSelectSpecials.addEventListener(MouseEvent.MOUSE_OUT,this.btnMouseOutScale,false,0,true);
         this.bgBar.gamesButton.visible = false;
         this.bgBar.herramientaCuadrado.buttonMode = true;
         this.bgBar.herramientaCuadrado.addEventListener(MouseEvent.MOUSE_OVER,this.onHerramientaCuadradoFrameOver);
         this.bgBar.herramientaCuadrado.addEventListener(MouseEvent.MOUSE_OUT,this.onHerramientaCuadradoFrameOut);
         this.bgBar.herramientaCuadrado.addEventListener(MouseEvent.CLICK,this.activarHerramientaCuadrado);
         TextFieldUtil.setHTML(this.bgBar.herramientaCuadrado.cuadradoText,Language.getLiteral(Language.ICON_SQUARE_TOOL));
         this.bgBar.achievementsButton.buttonMode = true;
         this.bgBar.achievementsButton.addEventListener(MouseEvent.MOUSE_DOWN,this.openWorldMenu);
         GameStatic.setButtonText(bgBar.achievementsButton.button,Language.ICON_MENU_WORLD);
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
         GameStatic.setButtonText(bgBar.iconMenuGift.giftButton.button,-1);
         TextFieldUtil.setHTML(this.bgBar.iconMenuGift.giftsText,Language.getLiteral(Language.ICON_MENU_GIFT_GIFTS));
         TextFieldUtil.setHTML(this.bgBar.iconMenuGift.newsText,Language.getLiteral(Language.ICON_MENU_GIFT_NEWS));
         TextFieldUtil.setHTML(this.bgBar.iconMenuGift.unitsText,Language.getLiteral(Language.ICON_MENU_GIFT_UNITS));
         TextFieldUtil.setHTML(this.bgBar.iconMenuGift.colText,Language.getLiteral(Language.ICON_MENU_GIFT_COLLECTIONS));
         this.bgBar.iconMenuWorld.visible = false;
         this.bgBar.iconMenuWorld.pvpButton.addEventListener(MouseEvent.CLICK,this.onPvp);
         this.bgBar.iconMenuWorld.questButton.addEventListener(MouseEvent.CLICK,this.goQuests);
         this.bgBar.iconMenuWorld.survivalButton.visible = false;
         this.bgBar.iconMenuWorld.survivalText.visible = false;
         this.bgBar.iconMenuWorld.tournamentButton.addEventListener(MouseEvent.CLICK,this.openPopupTournament);
         this.bgBar.iconMenuWorld.pvpButton.addEventListener(MouseEvent.MOUSE_OVER,this.showTooltipWorld);
         this.bgBar.iconMenuWorld.pvpButton.addEventListener(MouseEvent.MOUSE_OUT,this.removeTooltipWorld);
         this.bgBar.iconMenuWorld.questButton.addEventListener(MouseEvent.MOUSE_OVER,this.showTooltipWorld);
         this.bgBar.iconMenuWorld.questButton.addEventListener(MouseEvent.MOUSE_OUT,this.removeTooltipWorld);
         this.bgBar.iconMenuWorld.tournamentButton.addEventListener(MouseEvent.MOUSE_OVER,this.showTooltipWorld);
         this.bgBar.iconMenuWorld.tournamentButton.addEventListener(MouseEvent.MOUSE_OUT,this.removeTooltipWorld);
         TextFieldUtil.setHTML(this.bgBar.iconMenuWorld.questText,Language.getLiteral(Language.ICON_MENU_WORLD_QUEST));
         TextFieldUtil.setHTML(this.bgBar.iconMenuWorld.tournamentText,Language.getLiteral(Language.ICON_MENU_WORLD_TOURNEY));
         this.bgBar.iconMenuGames.visible = false;
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
            TextFieldUtil.setHTML(this.tooltip.tx,Language.getLiteral(Language.UNLOCK_LEVEL) + " " + Config.MIN_LEVEL_PVP.toString());
         }
         else if(param1.currentTarget.name == "questButton")
         {
            TextFieldUtil.setHTML(this.tooltip.tx,Language.getLiteral(Language.UNLOCK_LEVEL) + " " + Config.MIN_LEVEL_QUESTS.toString());
         }
         else if(param1.currentTarget.name == "survivalButton")
         {
            TextFieldUtil.setHTML(this.tooltip.tx,Language.getLiteral(Language.UNLOCK_LEVEL) + " " + Config.MIN_LEVEL_SURVIVAL.toString());
         }
         else if(param1.currentTarget.name == "tournamentButton")
         {
            if(parseInt(Base.Items.globals.TOURNAMENT_ACTIVATED) == 1)
            {
               TextFieldUtil.setHTML(this.tooltip.tx,Language.getLiteral(Language.UNLOCK_LEVEL) + " " + Config.MIN_LEVEL_TOURNAMENT.toString());
            }
            else
            {
               TextFieldUtil.setHTML(this.tooltip.tx,Language.getLiteral(Language.UNDER_MAINTENANCE));
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
            PopupQuestsManager.loadWorldBarco(param1);
         }
      }
      
      public function blockButtonsHerramientas() : void
      {
         this.bgBar.storeButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.storeButtMouse1);
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
         var _loc6_:DealSpotNPPIcon = null;
         var _loc4_:Number = 75;
         var _loc5_:Number = 10;
         this._viralButtonPanel = new IconPanel(_loc4_ + _loc5_,IconPanel.SIDE_RIGHT,(_loc4_ + _loc5_) * 3);
         this._viralButtonPanel.x = 760;
         this._viralButtonPanel.y = -360;
         addChildAt(this._viralButtonPanel,0);
         if(Base.Main.addDragonCityMobile)
         {
            this.showCrossDCiIcon();
         }
         if(param1 || Base.Main.showDailyBonus)
         {
            this.showDailybonusViralButtons();
         }
         KompuManager.api.checkViralButton();
         if(param1 || Base.Main.hasIphoneStorage)
         {
            this.showMobileGiftsViralButton();
         }
         if(Config.FB_PROMO_URI.indexOf("http") == 0)
         {
            _loc6_ = new DealSpotNPPIcon(Config.FB_PROMO_URI);
            this._viralButtonPanel.addIcon(_loc6_,this.removeDealSpotViralIcon);
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
         this.dailyButton = new DailyButtonTRMC();
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
      
      public function showCrossDCiIcon() : void
      {
         if(!this.dragonCityIOSButton)
         {
            this.dragonCityIOSButton = new CrossDCiViralIcon("crossDCi");
         }
         this._viralButtonPanel.addIcon(this.dragonCityIOSButton,this.dragonCityIOSButton.clickButton,"Dragon City Mobile");
         this._viralButtonPanel.changeToolTipOffsets(this.dragonCityIOSButton,100,32);
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
      
      private function onPvp(param1:MouseEvent) : void
      {
         if(Base.Player.iLevel >= Config.MIN_LEVEL_PVP)
         {
            this.bgBar.iconMenuWorld.visible = false;
            this.openPvp(null);
         }
      }
      
      public function addCashButtonClick(param1:MouseEvent = null) : void
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
            SIG_DAILY_BONUS_CLICKED.dispatch();
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
         var currentTab:int;
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
         currentTab = 1;
         this.tabs.push(null);
         while(currentTab < this.numTabsStore)
         {
            this.tabs.push(this.storeWindow.addChild(new Tab(this,135 + currentTab * 65,60,currentTab)));
            currentTab++;
         }
         this.tabs.push(null);
         this.tabs.push(null);
         this.tabs.push(null);
         this.tabs.push(null);
         this.tabs.push(this.storeWindow.addChild(new Tab(this,130,60,Config.CATEGORIA_MODE_NEW)));
         this.setChildIndex(this.storeWindow,this.numChildren - 1);
         this.tabs[1].mouseUsed();
      }
      
      public function btnMouseOverScale(param1:MouseEvent) : void
      {
         param1.currentTarget.scaleX = param1.currentTarget.scaleY = 1.05;
      }
      
      public function btnMouseOutScale(param1:MouseEvent) : void
      {
         param1.currentTarget.scaleX = param1.currentTarget.scaleY = 1;
      }
      
      public function destroy() : void
      {
         Base.Main.getStage().removeEventListener(MouseEvent.MOUSE_OVER,this.rufflefixHoverCheck,true);
         Base.Main.getStage().removeEventListener(MouseEvent.MOUSE_MOVE,this.rufflefixHoverCheck,true);
         Base.Main.removeEventListener(Event.ADDED,this.rufflefixSelectorAdded);
         var _loc1_:* = undefined;
         mouseChildren = false;
         mouseEnabled = false;
         for each(_loc1_ in this.buttons)
         {
            if(_loc1_ != null)
            {
               _loc1_.destroy();
            }
         }
         Base.Main.getStage().removeEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreenChange);
         this.buttons[7].removeEventListener(MouseEvent.CLICK,this.onFullScreenChange);
         this.bgBar.returnHome.removeEventListener(MouseEvent.MOUSE_DOWN,this.returnToMap);
         this.bgBar.normalMouse.removeEventListener(MouseEvent.MOUSE_DOWN,this.openMouseMenu);
         this.bgBar.bulldozer.removeEventListener(MouseEvent.MOUSE_DOWN,this.bulldozeMouse);
         this.topRight.nameText.removeEventListener(MouseEvent.MOUSE_OVER,this.showExperienceToolTip);
         this.topRight.nameText.removeEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
         this.topRight.nameText.removeEventListener(MouseEvent.MOUSE_DOWN,this.popUpNameTown);
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
      
      public function addGuiCover(param1:DisplayObject, param2:Number = 0.85) : void
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
            this.buttonCover.y = -y;
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
      
      public function resetWindow() : void
      {
         this.bgBar.giftCounter.visible = Base.Main.gifts.length > 0;
         TextFieldUtil.setHTML(this.bgBar.giftCounter.count,String(Base.Main.gifts.length));
         if(this.currentMenu)
         {
            this.currentMenu.resetWindow();
         }
      }
      
      public function toggleSound(param1:Event = null) : void
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
      
      private var rufflefixGuiHovered:Boolean = false;
      
      public function mouseOver(param1:MouseEvent) : void
      {
         this.rufflefixGuiHovered = true;
         Base.Main.disableMap();
      }
      
      // RUFFLE FIX: zero-size drag-selection box under the cursor (see the 0.9.26b patch).
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
      
      // RUFFLE FIX: missing MOUSE_OUT on the GUI after a hovered GUI element is removed (see the 0.9.26b patch).
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
      
      public function mouseOut(param1:MouseEvent) : void
      {
         this.rufflefixGuiHovered = false;
         if(this.zoomState == 0 && Base.PopUp.confirmWindow == null && this.expolorationWorld == null || Base.Main.tutorialMode)
         {
            Base.Main.enableMap();
         }
      }
      
      public function showCustomToolTip(param1:int, param2:int, param3:String, param4:Boolean = true, param5:String = "left") : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,param3,param1,param2,param5));
      }
      
      public function updateLevel(param1:int) : void
      {
         TextFieldUtil.setHTML(this.experienceBar.levelText,String(param1));
         this.adjustStats();
      }
      
      public function hideToolTip(... rest) : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
      }
      
      private function dongleButtMouse1(param1:MouseEvent = null) : void
      {
         if(!Base.Main.tutorialMode && Base.Main.gameModeCurrent == GameMode.NORMAL)
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
      
      public function adjustStats() : void
      {
         if(Base.Main.gameModeCurrent != GameMode.NORMAL)
         {
            return;
         }
         TextFieldUtil.setHTML(this.topLeft.coinText,this.getFormattedNumber(Base.Player.iGold));
         TextFieldUtil.setHTML(this.cash.getChildByName("dollarText"),this.getFormattedNumber(Base.Player.iCash));
         TextFieldUtil.setHTML(this.topLeft.woodText,this.getFormattedNumber(Base.Player.iWood));
         TextFieldUtil.setHTML(this.topLeft.stoneText,this.getFormattedNumber(Base.Player.iStone));
         TextFieldUtil.setHTML(this.topLeft.foodText,this.getFormattedNumber(Base.Player.iFood));
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
         TextFieldUtil.setHTML(this.topRight.visitorsText,Base.Player.iPopulationCurrent + "/" + Base.Player.iPopulationMax);
         if(Base.Player.iPopulationCurrent > Base.Player.iPopulationMax)
         {
            this.topRight.visitorsText.textColor = 16711680;
         }
         else if(Base.Player.iPopulationMax >= Config.MAX_POPULATION + Base.Iso.getAdditionalPopulation())
         {
            this.topRight.visitorsText.textColor = 255;
         }
         else
         {
            this.topRight.visitorsText.textColor = 0;
         }
      }
      
      public function setPlayerInfo() : void
      {
         this.setTownName();
         this.adjustStats();
      }
      
      public function setAssaultStats(param1:Object, param2:Object) : *
      {
      }
      
      public function setNeighborStats(param1:Object) : void
      {
         TextFieldUtil.setHTML(this.topRight.nameText,param1.playerInfo.map_names[0]);
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
         TextFieldUtil.setHTML(this.topLeft.coinText,param1.map.coins);
         TextFieldUtil.setHTML(this.cash.getChildByName("dollarText"),param1.playerInfo.cash);
         TextFieldUtil.setHTML(this.topLeft.woodText,param1.map.wood);
         TextFieldUtil.setHTML(this.topLeft.stoneText,param1.map.stone);
         TextFieldUtil.setHTML(this.topLeft.foodText,param1.map.food);
      }
      
      public function refreshNeighbourStats() : void
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
            this.topLeft.rayoNeighbour_05.visible = true;
            this.topLeft.rayoNeighbour_05.alpha = 1;
         }
         else if(this.topLeft.rayoNeighbour_05.visible)
         {
            this.fadeRayoNeighbour(this.topLeft.rayoNeighbour_05);
         }
         if(param1 >= 4)
         {
            this.topLeft.rayoNeighbour_04.visible = true;
            this.topLeft.rayoNeighbour_04.alpha = 1;
         }
         else if(this.topLeft.rayoNeighbour_04.visible)
         {
            this.fadeRayoNeighbour(this.topLeft.rayoNeighbour_04);
         }
         if(param1 >= 3)
         {
            this.topLeft.rayoNeighbour_03.visible = true;
            this.topLeft.rayoNeighbour_03.alpha = 1;
         }
         else if(this.topLeft.rayoNeighbour_03.visible)
         {
            this.fadeRayoNeighbour(this.topLeft.rayoNeighbour_03);
         }
         if(param1 >= 2)
         {
            this.topLeft.rayoNeighbour_02.visible = true;
            this.topLeft.rayoNeighbour_02.alpha = 1;
         }
         else if(this.topLeft.rayoNeighbour_02.visible)
         {
            this.fadeRayoNeighbour(this.topLeft.rayoNeighbour_02);
         }
         if(param1 >= 1)
         {
            this.topLeft.rayoNeighbour_01.visible = true;
            this.topLeft.rayoNeighbour_01.alpha = 1;
         }
         else if(this.topLeft.rayoNeighbour_01.visible)
         {
            this.fadeRayoNeighbour(this.topLeft.rayoNeighbour_01);
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
      
      public function hideViralButtonForTutorial() : void
      {
         if(this._viralButtonPanel != null)
         {
            this._viralButtonPanel.visible = false;
         }
      }
      
      public function setZoom(param1:Number) : void
      {
         this.bgBar.iconMenu.visible = false;
         this.bgBar.iconMenuGift.visible = false;
         this.bgBar.iconMenuWorld.visible = false;
         Base.Main.settings.data.zoom = param1;
         this.zoomSlider.setValue(param1);
      }
      
      public function onFullScreenChange(param1:FullScreenEvent = null) : void
      {
         var _loc2_:Point = null;
         this.sigFullScreenChange.dispatch(Base.Main.getStage().displayState);
         this.onRollOptions();
      }
      
      private function setToFullScreen(... rest) : void
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
            this.returnMouse();
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
         GuiManager.SIG_WORLD_BUTTON_CLICKED.dispatch();
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
         SIG_GIFT_BUTTON_CLICKED.dispatch();
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
         SIG_SELECTION_TOOL_CLICKED.dispatch();
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
      
      private function setToNormalScreen(... rest) : void
      {
         Base.Main.getStage().removeEventListener(Event.RENDER,this.setToNormalScreen);
      }
      
      public function toggleMusic(param1:Event = null) : void
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
      
      private function takePicture() : void
      {
      }
      
      private function enableExperienceBar(param1:Boolean) : void
      {
         if(param1)
         {
            this.topRight.nameText.addEventListener(MouseEvent.MOUSE_OVER,this.showExperienceToolTip);
            this.topRight.nameText.addEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
            this.topRight.nameText.addEventListener(MouseEvent.MOUSE_DOWN,this.popUpNameTown);
            this.topRight.visitorsText.addEventListener(MouseEvent.MOUSE_OVER,this.showPopulationTooltip);
            this.topRight.visitorsText.addEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
         }
         else
         {
            this.topRight.buttonMode = false;
            this.topRight.nameText.removeEventListener(MouseEvent.MOUSE_OVER,this.showExperienceToolTip);
            this.topRight.nameText.removeEventListener(MouseEvent.MOUSE_OUT,this.hideToolTip);
            this.topRight.nameText.removeEventListener(MouseEvent.MOUSE_DOWN,this.popUpNameTown);
         }
      }
      
      public function returnToMap(... rest) : void
      {
         if(Base.Main.gameModeCurrent == GameMode.NEIGHBOUR)
         {
            this.returnHome();
         }
         else if(Base.Main.gameModeCurrent == GameMode.ASSAULT)
         {
            if(!Base.Main.loadingData && Base.Main.mapaInicializado)
            {
               if(Base.Main.currentFriend == Constants.QUEST_SHIP || Base.Main.currentFriend == Constants.QUEST_SHIP_2)
               {
                  Quest.currentQuest.sendResults();
                  this.returnHome();
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
         else if(Base.Main.gameModeCurrent == GameMode.TOURNAMENT)
         {
            TournamentManager.pause();
         }
      }
      
      public function returnHome(param1:Boolean = false, param2:String = "") : void
      {
         Quest.currentQuest = null;
         Base.Main.loadMap("",String(Base.Main.townID),GameMode.NORMAL,false,param1,param2);
         Base.Sound.playSfx(SoundManager.SFX_BUTTON_CLICK);
         if(this.currentMenu != null && this.currentMenuInd == 6)
         {
            this.currentMenu.resetWindow();
         }
      }
      
      private function bulldozeMouse(... rest) : void
      {
         if(!Base.Main.tutorialMode && Base.Main.gameModeCurrent != GameMode.SURVIVAL)
         {
            Base.Main.setMouseToInquire();
            Base.Main.setMouseToBulldoze();
            Base.Sound.playSfx(SoundManager.SFX_BUTTON_CLICK);
            this.hideToolTip();
         }
      }
      
      private function selectAll(param1:MouseEvent) : void
      {
         Base.Iso.selectAllUnits();
      }
      
      private function selectSpecials(param1:MouseEvent) : void
      {
         Base.Iso.selectSpecialUnits();
      }
      
      private function popUpNameTown(param1:MouseEvent) : void
      {
         Base.Main.setMouseToInquire();
         this.addGuiCover(this);
         Base.Main.addChild(new EnterNamePopUp(Base.Main,0));
      }
      
      public function closeCurrentWindow(... rest) : void
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
      
      private function setTownName() : void
      {
         var _loc1_:String = Base.Player.playerInfo.map_names[Base.Main.townID];
         if(_loc1_ == "My Empire")
         {
            _loc1_ = Language.getLiteral(Language.INFO_EMPIRE_NAME);
         }
         TextFieldUtil.setHTML(this.topRight.nameText,_loc1_);
      }
      
      public function openWindow(param1:int) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.currentWindow) && this.currentWindowInd == param1)
         {
            return;
         }
         if(this.currentWindow)
         {
            this.currentWindow.destroy();
            this.currentWindow = null;
         }
         this.currentWindowInd = _loc2_ = param1;
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
                  this.currentMenu = this.storeWindow.addChild(new ExpandTab(73,170));
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
      
      public function removeGuiCover(param1:DisplayObject) : void
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
      
      public function addMisionBox() : void
      {
         if(this.missionBox == null && Base.Player.iLevel < Config.LEVEL_MAGIC)
         {
            this.missionBox = this.addChild(new MissionPopup(16,this.bgBar.y - 71)) as MissionPopup;
         }
         else
         {
            this.missionBox = this.addChild(new MissionPopup(16,this.bgBar.y - 71)) as MissionPopup;
            this.hideMissionMentor();
         }
      }
      
      public function refreshMisionBox() : void
      {
         this.missionBox.refreshGoals();
      }
      
      public function removeMisionBox() : void
      {
         if(this.missionBox != null)
         {
            this.removeChild(this.missionBox);
            GoalsManager.instance.bActive = false;
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
               "time":0.2,
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
               "time":0.2,
               "transition":"linear"
            });
         }
      }
      
      protected function showPopulationTooltip(param1:MouseEvent) : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,Language.getLiteral(Language.TOOLTIP_POPULATION),this.topRight.x + 330,this.topRight.y + 60,"top"));
      }
      
      private function showExperienceToolTip(param1:MouseEvent) : void
      {
         Tracing.Trace("showExperienceToolTip");
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,Language.getLiteral(Language.TOOLTIP_CAMBIAR_NOMBRE),this.topRight.x + 310,this.topRight.y - 15,"right"));
      }
      
      public function showMapToolTip(param1:MouseEvent) : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         var _loc2_:* = Language.getLiteral(Language.TOOLTIP_LUCHA);
         this.toolTip = this.addChild(new ToolTip(this,_loc2_,this.topRight.x + 260,this.topRight.y + 45,"top"));
      }
      
      public function showAddCashToolTip(param1:MouseEvent) : void
      {
         if(this.toolTip)
         {
            this.toolTip.destroy();
            this.toolTip = null;
         }
         this.toolTip = this.addChild(new ToolTip(this,Language.getLiteral(Language.TOOLTIP_GANAR_ORO),param1.currentTarget.x - 90,param1.currentTarget.y - 45,"top",50));
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
      
      public function openPvp(param1:Event = null) : void
      {
         if(Base.Main.gameModeCurrent == GameMode.NORMAL)
         {
            Base.Main.hideArrow();
            Base.Gui.recuadroInfo.clearSpecialUnitPortraits();
            if(Base.Player.iLevel < Config.MIN_LEVEL_PVP)
            {
               Base.PopUp.alert(Language.getLiteral(Language.AVISO_POCO_NIVEL_PARA_CONQUISTAR,[Config.MIN_LEVEL_PVP]));
               return;
            }
            if(Base.Iso.getCurrentArmy().length <= 0)
            {
               Base.PopUp.alert(Language.getLiteral(Language.NO_ARMY_ALERT));
               return;
            }
            Base.PopUp.openPopupPvp();
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
         if(Base.Player.iLevel == Config.LEVEL_MAGIC && Base.Main.gameModeCurrent == GameMode.NORMAL)
         {
            this.hideMissionMentor();
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
      
      public function unsetSpyMode() : void
      {
         bgBar.visible = true;
         topLeft.visible = true;
         experienceBar.visible = true;
         this.addMisionBox();
         this.addMagicBox(Base.Magic);
      }
      
      public function hideMissionMentor() : void
      {
         this.missionBox.btnHelp.visible = false;
         this.missionBox.mayor.visible = false;
         this.missionBox.btnClick.visible = false;
         this.missionBox.btnClick.removeEventListener(MouseEvent.MOUSE_OVER,this.missionBox.onMayorMouseOver);
         this.missionBox.btnClick.removeEventListener(MouseEvent.MOUSE_OUT,this.missionBox.onMayorMouseOut);
         this.missionBox.btnClick.removeEventListener(MouseEvent.MOUSE_DOWN,this.missionBox.openPopupSelect);
      }
      
      public function hideMissionBox() : void
      {
         if(this.missionBox != null)
         {
            this.missionBox.visible = false;
         }
      }
      
      public function addLikeViralButton() : void
      {
         if(this.fbLikeButton == null)
         {
            Base.AssetsLoader.loadAsset("externalized/viral_buttons//like.swf",function(param1:Object):void
            {
               var _loc2_:MovieClip = new (ApplicationDomain.currentDomain.getDefinition("LikeButtonMC") as Class)() as MovieClip;
               fbLikeButton = new Sprite();
               fbLikeButton.addChild(_loc2_);
               Base.Gui.viralButtonPanel.addIcon(fbLikeButton,Base.PopUp.openPopupLike);
            });
         }
         else
         {
            Base.Gui.viralButtonPanel.addIcon(this.fbLikeButton,Base.PopUp.openPopupLike);
         }
      }
   }
}

