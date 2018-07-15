function I = model2image(model, alpha , beta) 

shape  = coef2object( alpha, model.shapeMU, model.shapePC, model.shapeEV );
tex    = coef2object( beta,  model.texMU,   model.texPC,   model.texEV );

% Render it
rp   = defrp;
rp.width=500;
rp.height=500;
display_face(shape, tex, model.tl, rp);

set(gcf,'PaperPositionMode','auto');
cData = print('-RGBImage','-r96','-opengl');
I=cData;
