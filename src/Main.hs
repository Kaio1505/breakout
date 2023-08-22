module Main (main) where

import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort (ViewPort)
import System.Random (getStdGen, StdGen, split, randoms)


type Bola = ((Float,Float) ,(Float,Float), Picture)


desenhaBola :: Bola -> Picture
desenhaBola ((x,y), (vx,vy), p) = translate x y p

desenhaBolas2 :: [Bola] -> Picture
desenhaBolas2 xs = pictures $ map desenhaBola xs

atualizaMundo :: ViewPort -> Float -> [Bola] -> [Bola]
atualizaMundo vp dt pos_bola = map (atualizaVelocidade.atualizaPosicao dt) pos_bola

atualizaPosicao :: Float -> Bola -> Bola
atualizaPosicao dt ((x,y), (vx,vy), p) = ((x+vx*dt,y+vy*dt), (vx,vy), p)

atualizaVelocidade :: Bola -> Bola
atualizaVelocidade ((x,y), (vx,vy), p) 
    | x > lx = ((lx,y), (-vx,vy), p) 
    | x < -lx = ((-lx,y), (-vx,vy), p) 
    | y > ly = ((x,ly), (vx,-vy), p) 
    | y < -ly = ((x,-ly), (vx,-vy), p) 
    | otherwise = ((x,y), (vx,vy), p) 
    where
        lx = limiteX - raioBola
        ly = limiteY - raioBola

criaBola :: (Float, Float) -> (Float, Float) -> Color -> Bola
criaBola coord v cor = (coord,v,color cor $ circleSolid raioBola)
criaBolas :: StdGen -> Int -> [Bola]
criaBolas g qtd = take qtd (zipWith3 criaBola coords vels cores)
    where
        (pGen,angGen) = split g
        (xGen,yGen) = split pGen
        vel = 100
        convAng ang = (vel* (cos ang),vel*(sin ang))
        vels = map (\x -> convAng $ 2*x*pi ) $ randoms angGen
        convCoord x y = (x*2 *limiteX - limiteX, y*2 *limiteY - limiteY)
        coords = zipWith convCoord (randoms xGen) (randoms yGen)
        cores = cycle [white,red,cyan,yellow]


raioBola :: Num a => a
raioBola = 15

limiteX :: Num a => a
limiteX = 300

limiteY :: Num a => a
limiteY = 300

main :: IO ()
main = do
    g <- getStdGen
    let bolas = criaBolas g 1
    let bola = ((0.0,0.0),(50.0,50.0), (color red $ circleSolid raioBola))
    let bola2 = ((30.0,-50.0),(70.0,70.0), (color white $ circleSolid raioBola))

    let janela = InWindow "Breakout" (2*limiteX,2*limiteY) (50,50)
    simulate
        janela
        black
        60
        bolas
        desenhaBolas2
        atualizaMundo