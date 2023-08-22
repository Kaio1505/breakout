{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_breakout (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/vinikai/breakout/.stack-work/install/x86_64-linux/c442446d5d691f4271daa1596bd84200bb421e4380b7369b5287a55ce9ba1e09/9.4.6/bin"
libdir     = "/home/vinikai/breakout/.stack-work/install/x86_64-linux/c442446d5d691f4271daa1596bd84200bb421e4380b7369b5287a55ce9ba1e09/9.4.6/lib/x86_64-linux-ghc-9.4.6/breakout-0.1.0.0-3Rb1uMLUwPW7pjvfj0cH2U-breakout"
dynlibdir  = "/home/vinikai/breakout/.stack-work/install/x86_64-linux/c442446d5d691f4271daa1596bd84200bb421e4380b7369b5287a55ce9ba1e09/9.4.6/lib/x86_64-linux-ghc-9.4.6"
datadir    = "/home/vinikai/breakout/.stack-work/install/x86_64-linux/c442446d5d691f4271daa1596bd84200bb421e4380b7369b5287a55ce9ba1e09/9.4.6/share/x86_64-linux-ghc-9.4.6/breakout-0.1.0.0"
libexecdir = "/home/vinikai/breakout/.stack-work/install/x86_64-linux/c442446d5d691f4271daa1596bd84200bb421e4380b7369b5287a55ce9ba1e09/9.4.6/libexec/x86_64-linux-ghc-9.4.6/breakout-0.1.0.0"
sysconfdir = "/home/vinikai/breakout/.stack-work/install/x86_64-linux/c442446d5d691f4271daa1596bd84200bb421e4380b7369b5287a55ce9ba1e09/9.4.6/etc"

getBinDir     = catchIO (getEnv "breakout_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "breakout_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "breakout_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "breakout_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "breakout_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "breakout_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
