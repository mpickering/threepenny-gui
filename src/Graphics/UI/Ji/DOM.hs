module Graphics.UI.Ji.DOM where

import Graphics.UI.Ji

-- | A prettier bind.
(#) :: (Monad m) => m a -> (a -> m b) -> m b
(#) = (>>=)
infixl 1 #

-- | Append the element to a parent.
(#+) :: (MonadJi m) => m Element -> Element -> m Element
m #+ parent = m # addTo parent
infixl 1 #+

-- | Set the class of an element.
(#.) :: (MonadJi m) => m Element -> String -> m Element
m #. cls = m # setClass cls
infixl 1 #.

-- | Set the text of an element.
(#=) :: (MonadJi m) => m Element -> String -> m Element
m #= txt = m # setText txt
infixl 1 #=

-- | To this element, add this child.
addTo :: MonadJi m => Element -> Element -> m Element
addTo = appendTo

-- | Add this child, to that element.
add :: MonadJi m => Element -> Element -> m Element
add child parent = do
  appendTo parent child # unit
  return parent

-- | Set an attribute.
set :: (MonadJi m) => String -> String -> Element -> m Element
set = setAttr

-- | Discard the element chain.
unit :: Monad m => a -> m ()
unit =  \_ -> return ()

-- | Set the class of an element.
setClass :: (MonadJi m) => String -> Element -> m Element
setClass = set "class"
  
-- | Make a new div.
new :: MonadJi m => m Element
new = newElement "div"

-- | Remove the element.
remove :: MonadJi m => Element -> m ()
remove = delete

-- | Hide an element.
hide :: MonadJi m => Element -> m ()
hide el = setClass "hidden" el # unit